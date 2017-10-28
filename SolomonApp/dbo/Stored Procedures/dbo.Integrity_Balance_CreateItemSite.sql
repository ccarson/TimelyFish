 CREATE PROC Integrity_Balance_CreateItemSite
	@ProgID		CHAR(8),
	@UserID		CHAR(10)
AS
	SET NOCOUNT ON

	DECLARE	@CpnyID		CHAR(10),
		@InvtID		CHAR(30),
		@SiteID		CHAR(10)

	-- Create missing ItemSite records based on other distribution tables
	DECLARE CSR_ItemSiteCreate CURSOR LOCAL FAST_FORWARD FOR

	-- Generate combinations from Location
	SELECT	DISTINCT L.InvtID, L.SiteID
	FROM	Location L LEFT JOIN ItemSite T ON
			L.InvtID = T.InvtID AND
			L.SiteID = T.SiteID
	WHERE	T.InvtID IS NULL
	UNION

	-- Generate combinations from PurchOrdDet
	SELECT	DISTINCT D.InvtID, D.SiteID
	FROM	PurOrdDet D JOIN PurchOrd P ON
		D.PONbr  = P.PONbr
	   	JOIN Inventory I ON
		D.InvtID = I.InvtID
	   	LEFT JOIN ItemSite T ON
		D.InvtID = T.InvtID AND
		D.SiteID = T.SiteID
	WHERE	D.OpenLine = 1			-- only open lines
	AND	P.Status IN ('O', 'P')		-- PO status = Open or Printed
	AND	P.POType IN ('OR', 'DP')	-- PO type = Regular Order or Drop Ship
	AND	I.StkItem = 1			-- stock items only
	AND	T.InvtID IS NULL		-- missing ItemSite record
	UNION

	-- Generate combinations from SOPlan
	SELECT	DISTINCT P.InvtID, P.SiteID
	FROM	SOPlan P LEFT JOIN ItemSite T ON
		P.InvtID = T.InvtID AND
		P.SiteID = T.SiteID
	WHERE	T.InvtID IS NULL

	IF CURSOR_STATUS('LOCAL', 'CSR_ItemSiteCreate' ) > 0
	BEGIN
		CLOSE CSR_ItemSiteCreate
		DEALLOCATE CSR_ItemSiteCreate
	END

	-- Open cursor
	OPEN CSR_ItemSiteCreate
	FETCH NEXT FROM CSR_ItemSiteCreate INTO @InvtID, @SiteID

	-- Start cursor loop
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		-- Get Company Information from the Site table.
		SELECT @CpnyID = CpnyID FROM Site WHERE SiteID = @SiteID

		-- Insert the missing row (no blank fields allowed)
		IF LEN(@CpnyID) > 0 AND LEN(@InvtID) > 0 AND LEN(@SiteID) > 0
		BEGIN
			EXEC DMG_Insert_ItemSite @InvtID, @SiteID, @CpnyID, @ProgID, @UserID
		END

		FETCH NEXT FROM CSR_ItemSiteCreate INTO @InvtID, @SiteID
	END

	CLOSE CSR_ItemSiteCreate
	DEALLOCATE CSR_ItemSiteCreate



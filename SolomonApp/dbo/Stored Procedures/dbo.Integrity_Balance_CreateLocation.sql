 CREATE PROC Integrity_Balance_CreateLocation
	@ProgID		VARCHAR(8),
	@UserID		VARCHAR(10)
AS
	SET NOCOUNT ON

	DECLARE	@InvtID		VARCHAR(30),
		@SiteID		VARCHAR(10),
		@WhseLoc	VARCHAR(10)

	-- Creates missing Location records based on other distribution tables
	DECLARE CSR_LocationCreate CURSOR LOCAL FAST_FORWARD FOR

	-- Generate combinations from LotSerMst
	SELECT	DISTINCT M.InvtID, M.SiteID, M.WhseLoc
	FROM	LotSerMst M LEFT JOIN Location L ON
		M.InvtID = L.InvtID AND
		M.SiteID = L.SiteID AND
		M.WhseLoc = L.WhseLoc
	WHERE	L.InvtID IS NULL
	UNION

	-- Generate combinations from SOShipLine/SOShipLot
	SELECT	DISTINCT SL.InvtID, SL.SiteID, ST.WhseLoc
	FROM	SOShipLine SL JOIN SOShipLot ST ON
		SL.CpnyID = ST.CpnyID AND
		SL.ShipperID = ST.ShipperID AND
		SL.LineRef = ST.LineRef
		LEFT JOIN Location L ON
		SL.InvtID = L.InvtID AND
		SL.SiteID = L.SiteID AND
		ST.WhseLoc = L.WhseLoc
	WHERE	L.InvtID IS NULL
	UNION

	-- Generate combinations from INTran (regular)
	SELECT	DISTINCT T.InvtID, T.SiteID, T.WhseLoc
	FROM	INTran T LEFT JOIN Location L ON
		T.InvtID = L.InvtID AND
		T.SiteID = L.SiteID AND
		T.WhseLoc = L.WhseLoc
	WHERE	L.InvtID IS NULL
	UNION

	-- Generate combinations from INTran (transfers)
	SELECT	DISTINCT T.InvtID, T.ToSiteID, T.ToWhseLoc
	FROM	INTran T LEFT JOIN Location L ON
		T.InvtID = L.InvtID AND
		T.ToSiteID = L.SiteID AND
		T.ToWhseLoc = L.WhseLoc
	WHERE	L.InvtID IS NULL

	IF CURSOR_STATUS('LOCAL', 'CSR_LocationCreate' ) > 0
	BEGIN
		CLOSE CSR_LocationCreate
		DEALLOCATE CSR_LocationCreate
	END

	-- Open cursor
	OPEN CSR_LocationCreate
	FETCH NEXT FROM CSR_LocationCreate INTO @InvtID, @SiteID, @WhseLoc

	-- Start cursor loop
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		-- Insert the missing row (no blank fields allowed)
		IF LEN(@InvtID) > 0 AND LEN(@SiteID) > 0 AND LEN(@WhseLoc) > 0
		BEGIN
			EXEC DMG_Insert_Location @InvtID, @SiteID, @WhseLoc, @ProgID, @UserID
		END

		FETCH NEXT FROM CSR_LocationCreate INTO @InvtID, @SiteID, @WhseLoc
	END

	CLOSE CSR_LocationCreate
	DEALLOCATE CSR_LocationCreate



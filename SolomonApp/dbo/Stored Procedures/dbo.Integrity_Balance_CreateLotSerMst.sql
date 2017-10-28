 CREATE PROC Integrity_Balance_CreateLotSerMst
	@ProgID		VARCHAR(8),
	@UserID		VARCHAR(10)
AS
	SET NOCOUNT ON

	DECLARE	@InvtID		VARCHAR(30),
		@SiteID		VARCHAR(10),
		@WhseLoc	VARCHAR(10),
		@LotSerNbr	VARCHAR(25)

	-- Creates missing LotSerMst records based on other distribution tables
	DECLARE CSR_LotSerMstCreate CURSOR LOCAL FAST_FORWARD FOR

	-- Generate combinations from SOShipLot/SOShipLine
	SELECT	DISTINCT SL.InvtID, SL.SiteID, ST.WhseLoc, ST.LotSerNbr
	FROM	SOShipLine SL JOIN SOShipLot ST ON
		SL.CpnyID = ST.CpnyID AND
		SL.ShipperID = ST.ShipperID AND
		SL.LineRef = ST.LineRef
		LEFT JOIN LotSerMst M ON
		SL.InvtID = M.InvtID AND
		SL.SiteID = M.SiteID AND
		ST.WhseLoc = M.WhseLoc AND
		ST.LotSerNbr = M.LotSerNbr
		JOIN Inventory I ON
		ST.InvtID = I.InvtID
	WHERE	I.LotSerTrack IN ('LI', 'SI')
		AND M.InvtID IS NULL
	UNION

	-- Generate combinations from LotSerT
	SELECT	DISTINCT T.InvtID, T.SiteID, T.WhseLoc, T.LotSerNbr
	FROM	LotSerT T LEFT JOIN LotSerMst M ON
		T.InvtID = M.InvtID AND
		T.SiteID = M.SiteID AND
		T.WhseLoc = M.WhseLoc AND
		T.LotSerNbr = M.LotSerNbr
	WHERE	M.InvtID IS NULL

	IF CURSOR_STATUS('LOCAL', 'CSR_LotSerMstCreate' ) > 0
	BEGIN
		CLOSE CSR_LotSerMstCreate
		DEALLOCATE CSR_LotSerMstCreate
	END

	-- Open cursor
	OPEN CSR_LotSerMstCreate
	FETCH NEXT FROM CSR_LotSerMstCreate INTO @InvtID, @SiteID, @WhseLoc, @LotSerNbr

	-- Start cursor loop
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		-- Insert the missing row (no blank fields allowed)
		IF LEN(@InvtID) > 0 AND LEN(@SiteID) > 0 AND LEN(@WhseLoc) > 0 AND LEN(@LotSerNbr) > 0
		BEGIN
			EXEC DMG_Insert_LotSerMst @InvtID, @LotSerNbr, @SiteID, @WhseLoc, @ProgID, @UserID, 0
		END

		FETCH NEXT FROM CSR_LotSerMstCreate INTO @InvtID, @SiteID, @WhseLoc, @LotSerNbr
	END

	CLOSE CSR_LotSerMstCreate
	DEALLOCATE CSR_LotSerMstCreate



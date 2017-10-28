 CREATE PROCEDURE DMG_10400_Table_Validation
	/*Begin Parameters*/
	@BatNbr			VARCHAR(10),
	@ProcessName		VARCHAR(8),
	@UserName		VARCHAR(10),
	@UserAddress		VARCHAR(21),
	@PreRelease		Bit
	/*End Parameters*/
AS
-- Error Trapping
DECLARE	@Parm00		CHAR(30),
	@Parm01		CHAR(30),
	@Parm02		CHAR(30),
	@SQLErrorNbr	SMALLINT,
	@True		BIT,
	@False		BIT

SELECT	@True 		= 1,
	@False 		= 0

-- Cursor Fields
DECLARE
	@c_Errcode		VARCHAR(50),
	@c_InvtID		VARCHAR(30),
	@c_SiteID		VARCHAR(10),
	@c_Cost_QtyOnHand	SMALLINT,
	@c_Site_QtyOnHand	SMALLINT,
	@c_Cost_TotCost		SMALLINT,
	@c_Site_TotCost		SMALLINT,
	@c_WhseLoc		VARCHAR(10)

DECLARE	@SolomonErrCode		Integer
SET	@SolomonErrCode	= Case When @PreRelease = @True Then 16091 Else 16092 End
/*
Validates quantity between ItemCost and ItemSite
*/

IF CURSOR_STATUS('Local', 'Table_Cursor_1') > 0
BEGIN
	CLOSE Table_Cursor_1
	DEALLOCATE Table_Cursor_1
END

DECLARE Table_Cursor_1 CURSOR LOCAL FOR
	-- Compare INTran and vcc_IN_ItemCost_ItemSite
	SELECT
		cc.errcode,
		cc.InvtID,
		cc.SiteID,
		COALESCE( cc.ItemCost_QtyOnHand, 0 ),
		COALESCE( cc.ItemSite_QtyOnHand, 0 ),
		COALESCE( cc.ItemCost_TotCost, 0 ),
		COALESCE( cc.ItemSite_TotCost, 0 )
	FROM
		vcc_IN_ItemCost_ItemSite cc
	JOIN
		INTran i ON cc.InvtID = i.InvtID AND cc.SiteID = i.SiteID
	WHERE
		i.TranType NOT IN ('CT','CG')
	AND
		i.BatNbr = @BatNbr
	GROUP BY
		cc.errcode,
		cc.InvtID,
		cc.SiteID,
		cc.ItemCost_QtyOnHand,
		cc.ItemSite_QtyOnHand,
		cc.ItemCost_TotCost,
		cc.ItemSite_TotCost
	ORDER BY
		cc.InvtID,
		cc.SiteID

SELECT @SQLErrorNbr = @@ERROR
IF @SQLErrorNbr <> 0

BEGIN
	INSERT 	INTO IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
		Parm00)
	VALUES
		(@BatNbr, @UserAddress, 'DMG_10400_Table_Validation', @SQLErrorNbr, 1,
		 @BatNbr)
	GOTO Abort
END

OPEN Table_Cursor_1

FETCH NEXT FROM Table_Cursor_1 INTO	@c_errcode, @c_InvtID, @c_SiteID, @c_Cost_QtyOnHand, @c_Site_QtyOnHand,
					@c_Cost_TotCost, @c_Site_TotCost

SELECT @SQLErrorNbr = @@ERROR
IF @SQLErrorNbr <> 0
BEGIN
	INSERT 	INTO IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
		Parm00)
	VALUES
		(@BatNbr, @UserAddress, 'DMG_10400_Table_Validation', @SQLErrorNbr, 1,
		 @BatNbr)
	GOTO Abort
END

SELECT 	@Parm01 = 'ItemCost',
	@Parm02 = 'ItemSite'

WHILE  @@FETCH_STATUS = 0
      BEGIN     -- *********** Loop
		BEGIN
		/*
		Solomon Error Message
		*/
			IF (@c_Cost_QtyOnHand <> @c_Site_QtyOnhand)
			BEGIN
				SELECT @Parm00 = 'Quantity On Hand'
				INSERT 	INTO IN10400_RETURN
					(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
					Parm00, Parm01, Parm02, Parm03, Parm04,
					S4Future03, S4Future04)
				VALUES
					(@BatNbr, @UserAddress, 'DMG_10400_Table_Validation', @SolomonErrCode, 5,
					 @Parm00, @Parm01, @Parm02, @c_InvtID, @c_SiteID,
					@c_Cost_QtyOnHand, @c_Site_QtyOnHand)
			END

			IF (@c_Cost_TotCost <> @c_Site_TotCost)
			BEGIN
				SELECT @Parm00 = 'Total Cost'
				INSERT 	INTO IN10400_RETURN
					(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
					Parm00, Parm01, Parm02, Parm03, Parm04,
					S4Future03, S4Future04)
				VALUES
					(@BatNbr, @UserAddress, 'DMG_10400_Table_Validation', @SolomonErrCode, 5,
					@Parm00, @Parm01, @Parm02, @c_InvtID, @c_SiteID,
					@c_Cost_TotCost, @c_Site_TotCost)
			END
		END

		FETCH NEXT FROM Table_Cursor_1 INTO 	@c_errcode, @c_InvtID, @c_SiteID, @c_Cost_QtyOnHand, @c_Site_QtyOnHand,
							@c_Cost_TotCost, @c_Site_TotCost

	END

	CLOSE Table_Cursor_1
	DEALLOCATE Table_Cursor_1

/*
Validates quantity between Location and LotSerMst
*/

IF CURSOR_STATUS('LOCAL', 'Table_Cursor_2') > 0
BEGIN
	CLOSE Table_Cursor_2
	DEALLOCATE Table_Cursor_2
END

DECLARE Table_Cursor_2 CURSOR LOCAL FOR
-- Compare INTran and vcc_IN_Location_LotSerMst
SELECT
	cc.errcode,
	cc.InvtID,
	cc.SiteID,
	cc.WhseLoc,
	COALESCE( cc.Location_QtyOnHand, 0 ),
	COALESCE( cc.LotSerMst_QtyOnHand, 0 )
FROM
	vcc_IN_Location_LotSerMst cc
JOIN
	INTran i ON
	    cc.InvtID = i.InvtID
	    AND
	    cc.SiteID = i.SiteID
	    AND
	    cc.WhseLoc = i.WhseLoc
WHERE
	i.TranType NOT IN ('CT','CG')
AND
	i.BatNbr = @BatNbr
GROUP BY
	cc.errcode,
	cc.InvtID,
	cc.SiteID,
	cc.WhseLoc,
	cc.Location_QtyOnHand,
	cc.LotSerMst_QtyOnHand
ORDER BY
	cc.InvtID,
	cc.SiteID,
	cc.WhseLoc

SELECT @SQLErrorNbr = @@ERROR
IF @SQLErrorNbr <> 0

BEGIN
	INSERT 	INTO IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
		Parm00)
	VALUES
		(@BatNbr, @UserAddress, 'DMG_10400_Table_Validation', @SQLErrorNbr, 1,
		 @BatNbr)
	GOTO Abort
END

OPEN Table_Cursor_2

FETCH NEXT FROM Table_Cursor_2 INTO	@c_errcode, @c_InvtID, @c_SiteID, @c_WhseLoc, @c_Cost_QtyOnHand,
					@c_Site_QtyOnHand

SELECT @SQLErrorNbr = @@ERROR
IF @SQLErrorNbr <> 0
BEGIN
	INSERT 	INTO IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
		Parm00)
	VALUES
		(@BatNbr, @UserAddress, 'DMG_10400_Table_Validation', @SQLErrorNbr, 1,
		 @BatNbr)
	GOTO Abort
END

SELECT 	@Parm00 = 'Quantity On Hand',
	@Parm01 = 'Location',
	@Parm02 = 'LotSerMst'

WHILE  @@FETCH_STATUS = 0
      BEGIN     -- *********** Loop
		BEGIN
		/*
		Solomon Error Message
		*/
			INSERT 	INTO IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
				Parm00, Parm01, Parm02, Parm03, Parm04)
			VALUES
				(@BatNbr, @UserAddress, 'DMG_10400_Table_Validation', @SolomonErrCode, 5,
				 @Parm00, @Parm01, @Parm02, @c_InvtID, @c_SiteID)
		END

		FETCH NEXT FROM Table_Cursor_2 INTO	@c_errcode, @c_InvtID, @c_SiteID, @c_WhseLoc, @c_Cost_QtyOnHand,
							@c_Site_QtyOnHand

	END

	CLOSE Table_Cursor_2
	DEALLOCATE Table_Cursor_2

/*
Validates quantity between ItemSite and Location
*/

IF CURSOR_STATUS('LOCAL', 'Table_Cursor_3') > 0
BEGIN
	CLOSE Table_Cursor_3
	DEALLOCATE Table_Cursor_3
END

DECLARE Table_Cursor_3 CURSOR LOCAL FOR
-- Compare INTran and vcc_IN_ItemSite_Location
SELECT
	cc.errcode,
	cc.InvtID,
	cc.SiteID,
	COALESCE( cc.ItemSite_QtyOnHand, 0 ),
	COALESCE( cc.Location_QtyOnHand, 0 )
FROM
	vcc_IN_ItemSite_Location cc
JOIN
	INTran i ON
	    cc.InvtID = i.InvtID
	    AND
	    cc.SiteID = i.SiteID
WHERE
	i.TranType NOT IN ('CT','CG')
AND
	i.BatNbr = @BatNbr
GROUP BY
	cc.errcode,
	cc.InvtID,
	cc.SiteID,
	cc.ItemSite_QtyOnHand,
	cc.Location_QtyOnHand
ORDER BY
	cc.InvtID,
	cc.SiteID

SELECT @SQLErrorNbr = @@ERROR
IF @SQLErrorNbr <> 0

BEGIN
	INSERT 	INTO IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
		Parm00)
	VALUES
		(@BatNbr, @UserAddress, 'DMG_10400_Table_Validation', @SQLErrorNbr, 1,
		 @BatNbr)
	GOTO Abort
END

OPEN Table_Cursor_3

FETCH NEXT FROM Table_Cursor_3 INTO	@c_errcode, @c_InvtID, @c_SiteID, @c_Cost_QtyOnHand, @c_Site_QtyOnHand

SELECT @SQLErrorNbr = @@ERROR
IF @SQLErrorNbr <> 0
BEGIN
	INSERT 	INTO IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
		Parm00)
	VALUES
		(@BatNbr, @UserAddress, 'DMG_10400_Table_Validation', @SQLErrorNbr, 1,
		 @BatNbr)
	GOTO Abort
END

SELECT 	@Parm00 = 'Quantity On Hand',
	@Parm01 = 'ItemSite',
	@Parm02 = 'Location'

WHILE  @@FETCH_STATUS = 0
      BEGIN     -- *********** Loop
		BEGIN
		/*
		Solomon Error Message
		*/
			INSERT 	INTO IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
				Parm00, Parm01, Parm02, Parm03, Parm04)
			VALUES
				(@BatNbr, @UserAddress, 'DMG_10400_Table_Validation', @SolomonErrCode, 5,
				 @Parm00, @Parm01, @Parm02, @c_InvtID, @c_SiteID)
		END

		FETCH NEXT FROM Table_Cursor_3 INTO 	@c_errcode, @c_InvtID, @c_SiteID, @c_Cost_QtyOnHand, @c_Site_QtyOnHand

	END

	CLOSE Table_Cursor_3
	DEALLOCATE Table_Cursor_3

GOTO Finish

Abort:
	IF CURSOR_STATUS('LOCAL', 'Table_Cursor_1') > 0
	BEGIN
		CLOSE Table_Cursor_1
		DEALLOCATE Table_Cursor_1
	END
	IF CURSOR_STATUS('LOCAL', 'Table_Cursor_2') > 0
	BEGIN
		CLOSE Table_Cursor_2
		DEALLOCATE Table_Cursor_2
	END
	IF CURSOR_STATUS('LOCAL', 'Table_Cursor_3') > 0
	BEGIN
		CLOSE Table_Cursor_3
		DEALLOCATE Table_Cursor_3
	END
	RETURN @False

Finish:
	RETURN @True



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10400_Table_Validation] TO [MSDSL]
    AS [dbo];


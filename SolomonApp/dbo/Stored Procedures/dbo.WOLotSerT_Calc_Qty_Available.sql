 CREATE PROCEDURE WOLotSerT_Calc_Qty_Available
	@InvtID		varchar(30),
	@LotSerNbr	varchar(25),
	@SiteID		varchar(10),
	@WhseLoc	varchar(10),
	@WONbr		varchar(16),
	@TaskID		varchar(32),
	@TranSDType	varchar(2),
	@TranLineRef	varchar(5),
	@TranType	varchar(5),
	@PJTK_Key	varchar(24),
	@DecPlQty	smallint

AS

	DECLARE		@QtyAvailable		float
	DECLARE		@QtyCurrRecord		float

	SET		@QtyAvailable = 0
	SET		@QtyCurrRecord = 0

	-- Get Total QtyAvailable from LotSerMst
	SELECT 		@QtyAvailable =
			Round(QtyOnHand - QtyAlloc - QtyShipNotInv - QtyWORlsedDemand, @DecPlQty)
	FROM		LotSerMst (nolock)
	WHERE		InvtID = @InvtID
			and LotSerNbr = @LotSerNbr
			and SiteID = @SiteID
			and WhseLoc = @WhseLoc

	-- Now add back in any Qty from the Current record
	-- It may have been subtracted out as part of QtyWORlsedDemand
	SELECT		@QtyCurrRecord = Qty
	FROM		WOLotSerT (nolock)
	WHERE		WONbr = @WONbr
			and TaskID = @TaskID
			and TranSDType = @TranSDType
			and Tranlineref = @TranLineRef
			and TranType = @TranType
			and PJTK_Key = @PJTK_Key and Status <> 'R'
			and LotSerNbr = @LotSerNbr

	-- Return the Qty Available
	SELECT		Round(@QtyAvailable + @QtyCurrRecord, @DecPlQty)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



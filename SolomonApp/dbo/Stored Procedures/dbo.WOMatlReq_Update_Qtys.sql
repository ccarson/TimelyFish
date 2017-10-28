 CREATE PROCEDURE WOMatlReq_Update_Qtys
	@Mode		varchar( 2 ),
	@WONbr		varchar( 16 ),
	@TaskID		varchar( 32 ),
	@InvtID		varchar( 30 ),
	@LineRef	varchar( 5 ),
	@Qty		float,				-- Always positive, except when Mode = 'TT'
	@DecPlQty	smallint,
	@ProgId         VARCHAR( 8 ),
	@UserId         VARCHAR( 10 )

AS

	Set NOCOUNT ON

	DECLARE
	@LotSerTrack	varchar( 2 ),
	@QtyRemaining	float

	-- Determine if a Lot/Serial tracked item
	SELECT		@LotSerTrack = LotSerTrack
	FROM		Inventory (NOLOCK)
	WHERE		InvtID = @InvtID

	-- Calculate New QtyRemaining
	SELECT		@QtyRemaining =
				-- CU - Auto-complete to target WO (decreases qty remaining)
			CASE	WHEN @Mode = 'CU' then Round(QtyRemaining - @Qty, @DecPlQty)
				-- TT - Transfer-in to target WO (incoming @Qty is negative - decreases qty remaining)
				WHEN @Mode = 'TT' then Round(QtyRemaining + @Qty, @DecPlQty)
				-- TA - Transfer-out - Realloc (source) - increases qty remaining
				WHEN @Mode = 'TA' then Round(QtyRemaining + @Qty, @DecPlQty)
				-- SA - Scrap-out - Realloc (source) - increases qty remaining
				WHEN @Mode = 'SA' then Round(QtyRemaining + @Qty, @DecPlQty)
				-- TN, SN - Transfer Out - No Realloc - no change
			ELSE	QtyRemaining
			END
	FROM		WOMATLREQ
	WHERE 		WONbr = @WONbr and
	                Task = @TaskID and
	                LineRef = @LineRef

	-- Ensure that QtyRemaining does not fall below zero
	if Round(@QtyRemaining, @DecPlQty) < 0
		SELECT @QtyRemaining = 0

	-- Now update WOMatlReq buckets
	UPDATE 		WOMatlReq
	SET 		QtyAutoIssuedWO =
				CASE WHEN @Mode = 'CU' Then Round(QtyAutoIssuedWO + @Qty, @DecPlQty)
				ELSE QtyAutoIssuedWO
				END,
	 		QtyTransferInWO =
				CASE WHEN @Mode = 'TT' Then Round(QtyTransferInWO + Round(@Qty*-1, @DecPlQty), @DecPlQty)
				ELSE QtyTransferInWO
				END,
	 		QtyTransferOutReA =
				CASE WHEN @Mode = 'TA' Then Round(QtyTransferOutReA + @Qty, @DecPlQty)
				ELSE QtyTransferOutReA
				END,
	 		QtyTransferOutNoReA =
				CASE WHEN @Mode = 'TN' Then Round(QtyTransferOutNoReA + @Qty, @DecPlQty)
				ELSE QtyTransferOutNoReA
				END,
	 		QtyScrapReAlloc =
				CASE WHEN @Mode = 'SA' Then Round(QtyScrapReAlloc + @Qty, @DecPlQty)
				ELSE QtyScrapReAlloc
				END,
	 		QtyScrapNoReAlloc =
				CASE WHEN @Mode = 'SN' Then Round(QtyScrapNoReAlloc + @Qty, @DecPlQty)
				ELSE QtyScrapNoReAlloc
				END,
			LSLineCntr =
				CASE	WHEN @Mode IN ('CU', 'TA', 'TN', 'SA', 'SN') Then
				CASE	WHEN @LotSerTrack = 'SI' Then Round(LSLineCntr + @Qty, @DecPlQty)
					WHEN @LotSerTrack = 'LI' Then Round(LSLineCntr + 1, @DecPlQty)
					ELSE 0
					END
					ELSE 0
				END,
			QtyRemaining = @QtyRemaining,
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @ProgID,
			LUpd_User = @UserID
	WHERE 		WONbr = @WONbr and
	                Task = @TaskID and
	                LineRef = @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOMatlReq_Update_Qtys] TO [MSDSL]
    AS [dbo];


 CREATE PROCEDURE WOPJTran_Update_TransferToDate
   @FiscalNo   		varchar( 6 ),
   @System_CD  		varchar( 2 ),
   @Batch_ID   		varchar( 10 ),
   @Detail_Num    	int,
   @Qty			float,
   @DecPlQty		smallint

AS

	-- TR_ID07 contains Transfer/Scrapped Qty-to-Date for this original Issue (or transfer in)
	UPDATE		PJTran
	SET		TR_ID07 = Round(TR_ID07 + @Qty, @DecPlQty)
	WHERE		FiscalNo = @FiscalNo and
			System_CD = @System_CD and
			Batch_ID = @Batch_ID and
			Detail_Num = @Detail_Num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJTran_Update_TransferToDate] TO [MSDSL]
    AS [dbo];


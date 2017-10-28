 create proc WODeleteBatch
	@Module        char (2),
	@BatNbr        char (10)

as
set nocount on

   Delete from Batch Where BatNbr = @BatNbr and Module = @Module
   if (@@error = 0)
	 	print 'Delete Batch complete'

   -- IN Module Delete, only want unreleased trans
   If @Module = 'IN'
   	BEGIN
   	Delete from INTran Where BatNbr = @BatNbr and Rlsed = 0
      Delete from LotSerT Where BatNbr = @BatNbr and Rlsed = 0
      Delete from WOLotSerT Where BatNbr = @BatNbr and Status <> 'R'
   	END
	if (@@error = 0)
	 	print 'Delete INTran complete'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WODeleteBatch] TO [MSDSL]
    AS [dbo];


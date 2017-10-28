 Create Proc TrnsfrDoc_ReceiptBatch
    @ReceiptBatNbr varchar ( 10) as
Select * from TrnsfrDoc
    where S4Future11 = @ReceiptBatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TrnsfrDoc_ReceiptBatch] TO [MSDSL]
    AS [dbo];


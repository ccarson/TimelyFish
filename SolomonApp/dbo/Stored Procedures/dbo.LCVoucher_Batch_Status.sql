 CREATE PROCEDURE LCVoucher_Batch_Status
	@BatchNbr varchar( 10 )
	AS
	SELECT count(*)
	FROM Batch
	WHERE BatNbr = @BatchNbr
	and module = 'AP'
	and status IN ('U', 'P', 'V')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCVoucher_Batch_Status] TO [MSDSL]
    AS [dbo];


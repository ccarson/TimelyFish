 CREATE PROC MaxBatch_LineRef
	@BATNBR		VARCHAR(10)
AS
	SELECT MAX(LINEREF) FROM INTran (NoLock) Where BatNbr = @BATNBR



GO
GRANT CONTROL
    ON OBJECT::[dbo].[MaxBatch_LineRef] TO [MSDSL]
    AS [dbo];


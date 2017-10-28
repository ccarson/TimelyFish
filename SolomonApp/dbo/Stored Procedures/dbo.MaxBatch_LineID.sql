 CREATE PROC MaxBatch_LineID
	@BATNBR		VARCHAR(10)
AS
	SELECT MAX(LINEID) FROM INTran (NoLock) Where BatNbr = @BATNBR



GO
GRANT CONTROL
    ON OBJECT::[dbo].[MaxBatch_LineID] TO [MSDSL]
    AS [dbo];


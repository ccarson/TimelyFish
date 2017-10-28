 CREATE PROC LCReceipt_Delete
	@parm1 VARCHAR (10),
	@parm2 VARCHAR (10)
AS
	DELETE
	FROM LCReceipt
	WHERE batnbr = @parm1
	and rcptnbr = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCReceipt_Delete] TO [MSDSL]
    AS [dbo];


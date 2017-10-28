 CREATE PROC LCReceipt_Bat_Delete
	@parm1 VARCHAR (10),
	@parm2 VARCHAR (10)
AS
	DELETE
	FROM LCReceipt
	WHERE batnbr = @parm1
	and rcptnbr LIKE @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCReceipt_Bat_Delete] TO [MSDSL]
    AS [dbo];


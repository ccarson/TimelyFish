 CREATE PROC GetMaxLCCode
	@parm1 VARCHAR (10)
AS
	SELECT MAX(LCCode)
	FROM APTran
	WHERE batnbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetMaxLCCode] TO [MSDSL]
    AS [dbo];


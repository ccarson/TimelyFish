 CREATE PROCEDURE LCVoucher_APTRAN
	@parm1 VARCHAR(10),
	@parm2 VARCHAR(10),
	@parm3 VARCHAR(5)
AS
	SELECT *
	FROM aptran
	WHERE batnbr = @parm1
	and refnbr = @parm2
	and lineref = @parm3
	ORDER BY batnbr, refnbr, lineref



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCVoucher_APTRAN] TO [MSDSL]
    AS [dbo];


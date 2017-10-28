 CREATE PROC Grid_LCReceipt_LCCode
	@parm1 		VARCHAR (10),
	@parm2beg 	SMALLINT,
	@parm2end 	SMALLINT
AS
	SELECT *
	FROM	LCReceipt
		left outer join LCCode
			on LCReceipt.lccode = lccode.lccode
	WHERE	rcptnbr = @parm1
	and linenbr between @parm2beg and @parm2end
	ORDER BY rcptnbr, linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Grid_LCReceipt_LCCode] TO [MSDSL]
    AS [dbo];


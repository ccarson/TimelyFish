 CREATE	PROCEDURE LCVoucher_RcptNbr
	@parm1	VARCHAR(10),
	@parm2 VARCHAR(10),
	@parm3 VARCHAR(10),
	@parm4 VARCHAR(5)
AS
	SELECT	*
		FROM	LCVoucher
		WHERE	TranStatus = 'P'
		AND RcptNbr = @parm1
		AND	(APBatNbr <> @parm2 OR APRefNbr <> @parm3 OR APLineRef <> @parm4)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCVoucher_RcptNbr] TO [MSDSL]
    AS [dbo];


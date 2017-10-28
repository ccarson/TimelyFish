CREATE PROCEDURE POTran_RcptNbr_LineRef
	@parm1 varchar( 10 ),
	@parm2 varchar( 5 )
AS
	SELECT *
	FROM POTran
	WHERE RcptNbr LIKE @parm1
	   AND LineRef LIKE @parm2
	ORDER BY RcptNbr,
	   LineRef


GO
GRANT CONTROL
    ON OBJECT::[dbo].[POTran_RcptNbr_LineRef] TO [MSDSL]
    AS [dbo];


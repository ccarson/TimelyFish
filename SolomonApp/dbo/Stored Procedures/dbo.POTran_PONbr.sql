
 CREATE PROCEDURE POTran_PONbr
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM POTran
	WHERE PONbr LIKE @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[POTran_PONbr] TO [MSDSL]
    AS [dbo];


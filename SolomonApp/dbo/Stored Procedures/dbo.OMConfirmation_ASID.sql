
CREATE PROCEDURE OMConfirmation_ASID @parm1 int
AS
	SELECT *
	FROM SOHeader
	WHERE ASID = @parm1
	ORDER BY ASID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[OMConfirmation_ASID] TO [MSDSL]
    AS [dbo];


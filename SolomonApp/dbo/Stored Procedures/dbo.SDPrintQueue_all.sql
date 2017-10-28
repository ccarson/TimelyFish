 CREATE PROCEDURE SDPrintQueue_all
	@parm1 smallint

AS
	SELECT *
	FROM SDPrintQueue
	WHERE RI_ID = @Parm1
	ORDER BY RI_ID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SDPrintQueue_all] TO [MSDSL]
    AS [dbo];


 CREATE PROCEDURE SNPrintQueue_all
	@parm1 smallint

AS
	SELECT *
	FROM SNPrintQueue
	WHERE RI_ID = @Parm1
	ORDER BY RI_ID



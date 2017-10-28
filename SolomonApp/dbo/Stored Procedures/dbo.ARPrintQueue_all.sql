 CREATE PROCEDURE ARPrintQueue_all
	@parm1 smallint

AS
	SELECT *
	FROM ARPrintQueue
	WHERE RI_ID = @parm1
	ORDER BY RI_ID



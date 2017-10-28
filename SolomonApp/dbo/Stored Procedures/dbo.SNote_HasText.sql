CREATE PROCEDURE SNote_HasText @parm1 int
AS
	DECLARE @txt varchar(MAX)
	SELECT @txt = sNoteText FROM SNote WHERE nID = @parm1

	SELECT CASE WHEN RTRIM(@txt) = '' THEN 0
				ELSE 1
		   END



CREATE FUNCTION [dbo].[getSundayDate] (@mydate datetime)
RETURNS datetime
AS


    BEGIN

	IF (DATEPART(dw,@mydate) <> 1)
	BEGIN
		SET @mydate = @mydate - (DATEPART(dw,@mydate) - 1)
	END

    RETURN @mydate
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[getSundayDate] TO [db_sp_exec]
    AS [dbo];


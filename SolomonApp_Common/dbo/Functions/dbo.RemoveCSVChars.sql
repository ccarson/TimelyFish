

CREATE FUNCTION dbo.RemoveCSVChars (@str VARCHAR(8000))
RETURNS VARCHAR(8000)
AS


    BEGIN

    SELECT @str = REPLACE(@str, '"', '''')
    SELECT @str = REPLACE(@str, ',', ';')
    SELECT @str = REPLACE(@str, CHAR(10), ' ')
    SELECT @str = REPLACE(@str, CHAR(13), ' ')

    RETURN @str
END




GO
GRANT CONTROL
    ON OBJECT::[dbo].[RemoveCSVChars] TO [MSDSL]
    AS [dbo];


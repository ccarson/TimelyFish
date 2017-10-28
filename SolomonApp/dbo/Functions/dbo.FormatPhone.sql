CREATE FUNCTION FormatPhone (@phone CHAR(10))
RETURNS NVARCHAR(13)
AS


    BEGIN
    DECLARE @number CHAR(13)
    SELECT @number = ('(' + LEFT(@phone,3) + ')'
    + RIGHT(LEFT(@phone,6),3) + '-' + RIGHT(@phone,4))
    RETURN @number
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FormatPhone] TO PUBLIC
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FormatPhone] TO [se\earth~solomonapp~datareader]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[FormatPhone] TO [MSDSL]
    AS [dbo];


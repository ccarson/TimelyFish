 
CREATE FUNCTION dbo.PMLoadID 
( 
    @ContactName VARCHAR(32) 
) 
RETURNS VARCHAR(8000) 
AS 
BEGIN 
    DECLARE @r VARCHAR(8000) 
    SELECT @r = ISNULL(@r+',', '') 
        FROM dbo.ContactName
        WHERE ContactName = @ContactName 
    RETURN @r 
END 

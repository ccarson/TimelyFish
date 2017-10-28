
CREATE PROCEDURE XDDFileFormat_All
   @Selected	varchar(1),
   @FormatID	varchar(15)

AS
   SELECT * FROM XDDFileFormat WHERE Selected LIKE @Selected and FormatID LIKE @FormatID ORDER BY FormatID

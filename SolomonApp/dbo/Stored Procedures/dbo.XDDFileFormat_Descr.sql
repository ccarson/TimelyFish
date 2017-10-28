
CREATE PROCEDURE XDDFileFormat_Descr
   @FormatID	varchar(15)

AS
   SELECT       Descr
   FROM		XDDFileFormat (NoLock)
   WHERE	FormatID = @FormatID

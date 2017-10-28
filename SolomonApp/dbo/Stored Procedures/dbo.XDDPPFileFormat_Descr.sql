
CREATE PROCEDURE XDDPPFileFormat_Descr
   @FormatID	varchar(15)

AS
   SELECT       Descr
   FROM		XDDPPFileFormat (NoLock)
   WHERE	FormatID = @FormatID

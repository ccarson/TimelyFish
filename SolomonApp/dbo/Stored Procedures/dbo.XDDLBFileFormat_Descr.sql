
CREATE PROCEDURE XDDLBFileFormat_Descr
   @FormatID	varchar(15)

AS
   SELECT       Descr
   FROM		XDDLBFileFormat (NoLock)
   WHERE	FormatID = @FormatID


CREATE PROCEDURE XDDLBFileFormatDet_Delete
   @FormatID	varchar(15)
   

AS
   DELETE
   FROM         XDDLBFileFormatDet
   WHERE        FormatID = @FormatID

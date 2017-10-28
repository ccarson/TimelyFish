
CREATE PROCEDURE XDDLBFileFormat_All
   @FormatID	varchar(15)

AS
   SELECT       *
   FROM         XDDLBFileFormat
   WHERE        FormatID LIKE @FormatID
   ORDER BY     FormatID

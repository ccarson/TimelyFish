
CREATE PROCEDURE XDDPPFileFormat_All
   @Selected	varchar(1),
   @FormatID	varchar(15)

AS
   SELECT       *
   FROM         XDDPPFileFormat (nolock)
   WHERE        Selected LIKE @Selected
                and FormatID LIKE @FormatID
   ORDER BY     FormatID


CREATE PROCEDURE XDDFileFormat_FormatType_PV
   @Selected	varchar(1),
   @FormatType	varchar(1),
   @FormatID	varchar(15)

AS
   SELECT       FormatID, Descr, FormatType		-- replaced *, SWIM record len restriction
   FROM         XDDFileFormat
   WHERE        Selected LIKE @Selected
   		and FormatType LIKE @FormatType
                and FormatID LIKE @FormatID
   ORDER BY     FormatID

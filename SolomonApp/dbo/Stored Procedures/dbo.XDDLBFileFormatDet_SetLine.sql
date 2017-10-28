
CREATE PROCEDURE XDDLBFileFormatDet_SetLine
   @FormatID	varchar(15)

AS
   SELECT       FieldEnd,
    		FieldNbr,
    		FieldStart,
    		FieldType
   FROM         XDDLBFileFormatDet (nolock)
   WHERE        FormatID = @FormatID
   ORDER BY     FormatID, FieldNbr

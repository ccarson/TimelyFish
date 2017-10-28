
CREATE PROCEDURE XDDLBFileFormatDet_All
   @FormatID	varchar(15),
   @LineNbrBeg	smallint,
   @LineNbrEnd	smallint
   

AS
   SELECT       *
   FROM         XDDLBFileFormatDet
   WHERE        FormatID LIKE @FormatID
   		and LineNbr Between @LineNbrBeg and @LineNbrEnd
   ORDER BY     FormatID, LineNbr

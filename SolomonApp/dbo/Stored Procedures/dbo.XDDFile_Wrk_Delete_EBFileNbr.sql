
CREATE PROCEDURE XDDFile_Wrk_Delete_EBFileNbr
   @FileType		varchar(1),
   @EBFileNbr		varchar(6)

AS
   DELETE
   FROM		XDDFile_Wrk
   WHERE	FileType = @FileType
   		and EBFileNbr = @EBFileNbr

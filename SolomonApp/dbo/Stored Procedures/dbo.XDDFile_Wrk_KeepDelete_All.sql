
CREATE PROCEDURE XDDFile_Wrk_KeepDelete_All
   @FileType		varchar (1),
   @EBFileNbr		varchar (6),
   @KeepDelete		varchar (1)

AS
   UPDATE		XDDFile_Wrk
   SET			KeepDelete = @KeepDelete
   WHERE		FileType = @FileType
   			and EBFileNbr = @EBFileNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDFile_Wrk_KeepDelete_All] TO [MSDSL]
    AS [dbo];


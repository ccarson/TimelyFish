
CREATE PROCEDURE XDDBatch_Update_FileType
   @Module		varchar( 2 ),
   @BatNbr		varchar( 10 ),
   @FileType		varchar( 1 ),
   @BatSeq		smallint,
   @BatEFTGrp		smallint,
   @NewFileType		varchar( 1 )	

AS

   UPDATE	XDDBatch
   SET		FileType = @NewFileType
   WHERE	Module = @Module
   		and BatNbr = @BatNbr
   		and FileType = @FileType
   		and BatSeq = @BatSeq
   		and BatEFTGrp = @BatEFTGrp

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatch_Update_FileType] TO [MSDSL]
    AS [dbo];


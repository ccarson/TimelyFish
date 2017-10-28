
CREATE PROCEDURE XDDBatch_Clear_EBFileNbr
	@FileType 	varchar( 1 ),
	@EBFileNbr	varchar( 6 ),
  	@UpdUser	varchar( 10 ),
  	@UpdProg	varchar( 5 )

AS


	UPDATE		XDDBatch
	SET		EBFileNbr = '',
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @UpdProg,
			LUpd_User = @UpdUser
	WHERE		FileType = @FileType
			and EBFileNbr = @EBFileNbr


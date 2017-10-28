 -- USETHISSYNTAX

/****** Object:  Stored Procedure dbo.pp_01400    Script Date: 5/20/99 11:22:07 AM ******/
CREATE PROCEDURE GL_UpdtDtTime
	@pBatNbr varchar(10),		--Batnbr which is to be updated.
	@pModule VarChar ( 2),		--Module for Batch
	@pNew 	Varchar(1),		--Specifies if Batch is New Batch or Existing.
    				        --Values are 'T' for new Batch,'F' for existing.
	@pUserID Varchar(10),
	@pScreenID VarChar(8)
	AS

Set NoCount ON
SET DEADLOCK_PRIORITY  Low

/***** Start transaction set. *****/
BEGIN TRANSACTION

	If @pNew = 'T'

	   Begin
	   /**Update Batch with time**/
	   Update Batch
		SET Crtd_DateTime = GetDate(),
		Crtd_User = @pUserID,
		Crtd_Prog = @pScreenID,
		LUpd_DateTime = GetDate(),
		LUpd_User = @pUserID,
		LUpd_Prog = @pScreenID
           WHERE BatNbr = @pBatNbr AND Module = @pModule
	   IF @@ERROR < > 0 GOTO ABORT

	   /**Update GlTran with time**/
	   UPDATE GLTran
		SET Crtd_DateTime = GetDate(),
		Crtd_User = @pUserID,
		Crtd_Prog = @pScreenID,
		LUpd_DateTime = GetDate(),
		LUpd_User = @pUserID,
		LUpd_Prog = @pScreenID
           WHERE BatNbr = @pBatNbr AND Module = @pModule
	   IF @@ERROR < > 0 GOTO ABORT
	   End

	If @pNew = 'F'

	   Begin
	   /**Update Batch with LUpd_DateTime **/
	   Update Batch
		SET LUpd_DateTime = GetDate(),
		LUpd_User = @pUserID,
		LUpd_Prog = @pScreenID
           WHERE BatNbr = @pBatNbr AND Module = @pModule
	   IF @@ERROR < > 0 GOTO ABORT

	   /**Update GlTran with LUpd_DateTime **/
	   UPDATE GLTran
		SET LUpd_DateTime = GetDate(),
		LUpd_User = @pUserID,
		LUpd_Prog = @pScreenID
           WHERE BatNbr = @pBatNbr AND Module = @pModule
	   IF @@ERROR < > 0 GOTO ABORT
	   End
	COMMIT TRANSACTION

GOTO FINISH

ABORT:
ROLLBACK TRANSACTION

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GL_UpdtDtTime] TO [MSDSL]
    AS [dbo];


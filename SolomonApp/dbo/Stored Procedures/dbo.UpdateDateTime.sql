 -- USETHISSYNTAX

/****** Object:  Stored Procedure dbo.UpdateDateTime    Script Date: 6/03/99 11:22:07 AM ******/
CREATE PROCEDURE UpdateDateTime
	@pCompName varchar(10),		--Name of the Computer.
	@pUser 	Varchar(10),		--Current User.
	@pScreen VarChar(8),		--SereenID from Which Proc is called.
	@pTable	 VarChar(20),		--Table to be updated.
	@pInserted VarChar(1),		--Parameter Specifying weather a record is updated
					--Or Inserted,If Updated then only Update Lupd fields.
					--Values are T:True and F:False.
	@pWhereCond VarChar(300)	--Where condition to specify which records are to be
					--updated for Crtd and Lupd fields.

	AS

Set NoCount ON
SET DEADLOCK_PRIORITY  Low
DECLARE @SqlStr As VarChar(500)		-- 94 + 20 + Date + 8 + 10 + Date + 8 + 10 + Len(WhereCondn)

/***** Start transaction set. *****/
BEGIN TRANSACTION

	If @pInserted = 'T'

	   Begin
	   /**Update pTable with Crtd and Lupd fields **/
	   Select @SqlStr = "Update " + @pTable +
		" SET Crtd_DateTime = '" + CAST(GetDate()As Varchar) +
		"' ,Crtd_Prog = '" + @pScreen +
		"' ,Crtd_User = '" + @pUser +
                "' ,LUpd_DateTime = '" + CAST(GetDate()As Varchar) +
		"' ,LUpd_Prog = '" + @pScreen +
      		"' ,LUpd_User = '" + @pUser +
	        "' WHERE " + @pWhereCond
	   End

	If @pInserted = 'F'

	   Begin
	   /**Update pTable with LUpd  fields **/
	   Select @SqlStr = "Update " + @pTable +
		" SET LUpd_DateTime = '" + CAST(GetDate()As Varchar) +
                "' ,LUpd_Prog = '" + @pScreen +
		"' ,LUpd_User = '" + @pUser +
                "' WHERE " + @pWhereCond
	   End

	/* Execute the SqlStr build depending on above condition */
        EXEC (@SqlStr)
  	IF @@ERROR < > 0 GOTO ABORT
--Print @SqlStr
--Print @@Error

COMMIT TRANSACTION

GOTO FINISH

ABORT:
ROLLBACK TRANSACTION

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[UpdateDateTime] TO [MSDSL]
    AS [dbo];


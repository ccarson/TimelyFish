 /****** Object:  Stored Procedure dbo.APCheck_Delete    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APCheck_Delete @parm1 varchar ( 10), @UserID varchar(10), @ScrNbr varchar (5) as
---used when a check batch is deleted
BEGIN TRANSACTION

	---Reset the doc that was to be paid back so it can be
	---re-selected in another batch
	update apdoc set
          APDoc.Selected = 0,
          APDoc.DiscTkn = 0,
          APDoc.PmtAmt = 0,
          APDoc.CuryDiscTkn = 0,
          APDoc.CuryPmtAmt = 0,
		  APDoc.BWAmt = 0,
		  APDoc.CuryBWAmt = 0,
          LUpd_Prog = @ScrNbr,
	  LUpd_DateTime = getdate(),
	  LUpd_User = @UserID
      from apdoc, apcheckdet
	  where apcheckdet.refnbr = apdoc.refnbr
	  and apcheckdet.doctype = apdoc.doctype
	  and apcheckdet.batnbr = @parm1
	IF @@ERROR <> 0 GOTO ABORT

	---delete all of the apcheckdet records for this batch
	delete from apcheckdet where batnbr = @parm1
	IF @@ERROR <> 0 GOTO ABORT
		---delete all of the apcheck records for this batch
	delete from apcheck where batnbr = @parm1

IF @@ERROR <> 0 GOTO ABORT

	---set this check batch to a Void status
	update batch set status = 'V', rlsed = 1 where batnbr = @parm1 and module = "AP"

IF @@ERROR <> 0 GOTO ABORT

GOTO NOERRORS

ABORT:
ROLLBACK TRANSACTION
GOTO FINISH

NOERRORS:
COMMIT TRANSACTION

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APCheck_Delete] TO [MSDSL]
    AS [dbo];


 CREATE proc APCheckSel_SetSelected @UserID varchar(10), @AccessNbr smallint, @Preview smallint, @APResult Int OUTPUT
AS
	set nocount on
		IF @PreView = 0
	BEGIN
		delete from wrkchecksel
		from apdoc inner join wrkchecksel
		on	WrkCheckSel.Accessnbr = @AccessNbr
		AND	APDoc.Acct = WrkCheckSel.Acct
		AND	APDoc.Sub = WrkCheckSel.Sub
		AND	APDoc.DocType = WrkCheckSel.DocType
		AND	APDoc.RefNbr = WrkCheckSel.RefNbr
		AND 	APDoc.selected = 1
		IF @@ERROR < > 0 GOTO ABORT
	END

	IF @PreView = 0
	BEGIN
		update APDoc set selected = 1,
			LUpd_Prog = '03500',
			LUpd_DateTime = getdate(),
			LUpd_User = @UserID
		from APDoc inner join wrkchecksel
		on	WrkCheckSel.Accessnbr = @AccessNbr
		AND	APDoc.Acct = WrkCheckSel.Acct
		AND	APDoc.Sub = WrkCheckSel.Sub
		AND	APDoc.DocType = WrkCheckSel.DocType
		AND	APDoc.RefNbr = WrkCheckSel.RefNbr
		WHERE   APDoc.Selected = 0
		IF @@ERROR < > 0 GOTO ABORT
	END
	SELECT @APResult = 1
GOTO FINISH

ABORT:
SELECT @APResult = 0

FINISH:



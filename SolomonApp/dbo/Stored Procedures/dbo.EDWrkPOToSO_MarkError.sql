 CREATE Proc EDWrkPOToSO_MarkError @AccessNbr smallint As
Update ED850Header Set UpdateStatus = 'CE' Where EDIPOID In (Select Distinct EDIPOID From
EDWrkPOToSO Where AccessNbr = @AccessNbr And EDIPOID In (Select Distinct EDIPOID From
EDWrkPOToSO Where AccessNbr = @AccessNbr And POQTY <> SOQTY))
Select Cast(@@ROWCOUNT As int)



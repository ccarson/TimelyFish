 CREATE Proc EDWrkPOToSO_MarkConverted @AccessNbr smallint As
Update ED850Header Set UpdateStatus = 'OC' Where EDIPOID In (Select Distinct EDIPOID From
EDWrkPOToSO Where AccessNbr = @AccessNbr And EDIPOID Not In (select Distinct EDIPOID From
EDWrkPOToSO Where AccessNbr = @AccessNbr And POQTY <> SOQTY))



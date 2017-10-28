 Create Proc EDWrkPOToSO_UpdateStatus @AccessNbr smallint As
Update ED850Header Set UpdateStatus = 'CE' From ED850Header A, EDWrkPOToSO B Where
A.CpnyId = B.CpnyId And A.EDIPOID = B.EDIPOID And B.AccessNbr = @AccessNbr And B.POQty <> B.SOQty



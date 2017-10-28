 CREATE Proc ED850Header_Imported As Select A.CpnyId, A.EDIPOID, A.NoteId, B.OrdNbr From
ED850Header A, SOHeader B Where A.EDIPOID = B.EDIPOID And A.UpdateStatus = 'IN' And B.Cancelled = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Header_Imported] TO [MSDSL]
    AS [dbo];


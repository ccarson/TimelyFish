 CREATE Proc EDSOHeader_NoteCopy @AccessNbr smallint As
Update SOHeader Set NoteId = B.NoteId From SOHeader A Inner Join ED850Header B On A.CpnyId =
B.CpnyId And A.EDIPOID = B.EDIPOID Where A.EDIPOID In (Select EDIPOID From EDWrkPOToSO Where
AccessNbr = @AccessNbr)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOHeader_NoteCopy] TO [MSDSL]
    AS [dbo];


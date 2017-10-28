 Create Proc EDSnote_GetNote @NoteId int As
Declare @NoteText char(8000)
Select @NoteText = Left(Cast(sNoteText As Char),8000) From Snote Where nId = @NoteId
Select @NoteText



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSnote_GetNote] TO [MSDSL]
    AS [dbo];


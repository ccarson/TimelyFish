 Create Proc EDSnote_Copy @nid int As
Declare @NoteId int
Insert Into Snote (dtRevisedDate,sLevelName,sTableName,sNoteText) Select dtRevisedDate,sLevelName,sTableName,sNoteText From SNote Where Nid = @nid
Select @NoteId = @@Identity
Select @NoteId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSnote_Copy] TO [MSDSL]
    AS [dbo];


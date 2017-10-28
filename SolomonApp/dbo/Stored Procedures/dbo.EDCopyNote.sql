 Create Proc EDCopyNote @NoteID int, @Level varchar(20), @Table varchar(20)
As
	Insert Into Snote Select GetDate(), @Level,@Table,sNoteText,Null From SNote Where nID = @NoteID
	Select Cast(@@Identity As int)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDCopyNote] TO [MSDSL]
    AS [dbo];


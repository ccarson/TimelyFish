CREATE PROCEDURE pcftNoteSubject_NoteSubject
	@parm1 varchar(30)
	As
	SELECT * FROM cftNoteSubject
	WHERE NoteSubject LIKE @parm1
	ORDER BY NoteSubject

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pcftNoteSubject_NoteSubject] TO [MSDSL]
    AS [dbo];


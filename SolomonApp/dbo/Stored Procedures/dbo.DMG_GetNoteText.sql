 CREATE PROCEDURE DMG_GetNoteText
	@NoteID		integer
AS
	DECLARE	@sNoteText	char(8000)

	SELECT	@sNoteText = sNoteText
	FROM	Snote
	WHERE	nID = @NoteID

	IF @@ROWCOUNT = 0
		SELECT	@sNoteText = ''
	ELSE
		SELECT	convert(text,@sNoteText)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_GetNoteText] TO [MSDSL]
    AS [dbo];


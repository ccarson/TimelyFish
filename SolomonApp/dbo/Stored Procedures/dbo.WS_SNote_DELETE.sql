CREATE PROCEDURE WS_SNote_DELETE
	@NoteID int,
	@time_stamp timestamp
AS
	IF NOT EXISTS (SELECT * FROM vs_attachment WHERE NoteId = @NoteID)
	BEGIN
		DELETE FROM SNote WHERE nID = @NoteID AND tstamp = @time_stamp
	END
	ELSE
	BEGIN
		UPDATE Snote SET sNoteText = '' WHERE nID = @NoteID AND tstamp = @time_stamp
	END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_SNote_DELETE] TO [MSDSL]
    AS [dbo];


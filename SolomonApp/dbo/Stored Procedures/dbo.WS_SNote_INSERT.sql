CREATE PROCEDURE WS_SNote_INSERT
	@NoteDate smalldatetime,
	@LevelName char(20),
	@TableName char(20),
	@NoteText text
AS
	INSERT INTO SNote (dtRevisedDate, sLevelName, sTableName, sNoteText)
	VALUES (@NoteDate, @LevelName, @TableName, @NoteText);
	
	SELECT SCOPE_IDENTITY()

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_SNote_INSERT] TO [MSDSL]
    AS [dbo];


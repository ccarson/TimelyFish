CREATE PROCEDURE TablesWithNoteId @parm1 char(20)
AS
	SELECT t.name FROM sys.tables t WHERE t.name LIKE @parm1 AND EXISTS(SELECT c.name FROM sys.columns c WHERE c.object_id = t.object_id AND c.name = 'NoteId') ORDER BY t.name

CREATE PROCEDURE NotableTables
AS
	SELECT t.name FROM sys.tables t WHERE EXISTS(SELECT c.name FROM sys.columns c WHERE c.object_id = t.object_id AND c.name = 'NoteId') ORDER BY t.name

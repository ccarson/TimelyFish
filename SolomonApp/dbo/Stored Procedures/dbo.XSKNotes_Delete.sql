
create procedure XSKNotes_Delete
	@nID 			int
as

	DELETE 	FROM	sNote
	WHERE	nID = @nID


create procedure XDDNotes_Delete
	@nID		int
as

	DELETE 	FROM	sNote
	WHERE	nID = @nID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDNotes_Delete] TO [MSDSL]
    AS [dbo];


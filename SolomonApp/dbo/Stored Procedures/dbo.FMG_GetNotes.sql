 create procedure FMG_GetNotes
	@nID integer,
	@sNoteText varchar(8000) OUTPUT
as
	select	@sNoteText = sNoteText
	from	Snote
	where	nID = @nID

	if @@ROWCOUNT = 0 begin
		set @sNoteText = ''
		return 0	--Failure
	end
	else
		--select @sNoteText
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_GetNotes] TO [MSDSL]
    AS [dbo];


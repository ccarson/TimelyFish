
create procedure XSKNotes_Put
	@nID 			int,
	@sLevelName 		varchar(20),
	@sTableName 		varchar(20),
	@sNoteText 		varchar(8000)
as
	set nocount on

	-- If this is an existing note id
	if @nID <> 0
	BEGIN

		-- Update the note text
		UPDATE		Snote
		SET		sNoteText = @sNoteText,
				dtRevisedDate = getdate()
		WHERE		nID = @nID

	END
	
	else
	
	BEGIN
		-- Create a new note record
		Insert	Snote(dtRevisedDate, sLevelName, sTableName, sNoteText)
		Values	(cast(getdate() as smalldatetime), @sLevelName, @sTableName, @sNoteText)

		set @nID = @@IDENTITY
	END

	SELECT	@nID

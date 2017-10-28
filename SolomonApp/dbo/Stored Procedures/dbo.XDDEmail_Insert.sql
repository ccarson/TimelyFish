
create procedure XDDEmail_Insert
	@LineFull		varchar( 510 )
AS

	declare @Line		varchar( 255 )
	declare @LinePlus	varchar( 255 )

	if len(rtrim(@LineFull)) <= 255
	BEGIN
		SET @Line = rtrim(@LineFull)
		SET @LinePlus = ''
	END
	else
	BEGIN
		SET @Line = Left(@LineFull, 255)
		SET @LInePlus = right(@LineFull, len(@LineFull) - 255)
	END	

	INSERT	INTO #TempTable
	(LineOut, LineOutPlus)
	VALUES
	(@Line, @LinePlus)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDEmail_Insert] TO [MSDSL]
    AS [dbo];


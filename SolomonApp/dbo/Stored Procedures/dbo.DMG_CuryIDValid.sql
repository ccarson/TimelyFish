 create procedure DMG_CuryIDValid
	@CuryID varchar(4)
as
	if (
	select	count(*)
	from	Currncy (NOLOCK)
	where	CuryID = @CuryID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CuryIDValid] TO [MSDSL]
    AS [dbo];


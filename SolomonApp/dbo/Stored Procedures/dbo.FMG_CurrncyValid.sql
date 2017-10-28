 create procedure FMG_CurrncyValid
	@CuryId	varchar(4)
as
	if (
	select	count(*)
	from	Currncy (NOLOCK)
	where	CuryId = @CuryId
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_CurrncyValid] TO [MSDSL]
    AS [dbo];


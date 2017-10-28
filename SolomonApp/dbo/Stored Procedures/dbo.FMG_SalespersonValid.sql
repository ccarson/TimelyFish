 create procedure FMG_SalespersonValid
	@SlsPerId	varchar(10)
as
	if (
	select	count(*)
	from	Salesperson (NOLOCK)
	where	SlsPerId = @SlsPerId
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_SalespersonValid] TO [MSDSL]
    AS [dbo];


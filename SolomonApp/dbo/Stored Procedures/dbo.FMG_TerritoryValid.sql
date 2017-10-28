 create procedure FMG_TerritoryValid
	@Territory	varchar(10)
as
	if (
	select	count(*)
	from	Territory (NOLOCK)
	where	Territory = @Territory
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_TerritoryValid] TO [MSDSL]
    AS [dbo];


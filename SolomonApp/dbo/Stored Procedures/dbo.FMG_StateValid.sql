 create procedure FMG_StateValid
	@StateProvID	varchar(3)
as
	if (
	select	count(*)
	from	State (NOLOCK)
	where	StateProvID = @StateProvID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_StateValid] TO [MSDSL]
    AS [dbo];


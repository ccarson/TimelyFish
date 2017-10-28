 create procedure DMG_AddrIDValid
	@AddrID		varchar(10)
as
	if (
	select	count(*)
	from	Address (NOLOCK)
	where	AddrID = @AddrID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



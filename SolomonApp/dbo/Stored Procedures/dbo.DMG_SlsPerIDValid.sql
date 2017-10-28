 create procedure DMG_SlsPerIDValid
	@SlsPerID	varchar(10)
as
	if (
	select	count(*)
	from	Salesperson (NOLOCK)
	where	SlsPerID = @SlsPerID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SlsPerIDValid] TO [MSDSL]
    AS [dbo];


 create procedure DMG_ReasonCdValid
	@ReasonCd	varchar(6)
as
	if (
	select	count(*)
	from	ReasonCode (NOLOCK)
	where	ReasonCd = @ReasonCd
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ReasonCdValid] TO [MSDSL]
    AS [dbo];


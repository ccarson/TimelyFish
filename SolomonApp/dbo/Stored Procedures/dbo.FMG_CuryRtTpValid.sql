 create procedure FMG_CuryRtTpValid
	@RateTypeId	varchar(6)
as
	if (
	select	count(*)
	from	CuryRtTp (NOLOCK)
	where	RateTypeId = @RateTypeId
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_CuryRtTpValid] TO [MSDSL]
    AS [dbo];


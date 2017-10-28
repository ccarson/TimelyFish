 create procedure DMG_RateTypeIDValid
	@RateTypeID varchar(6)
as
	if (
	select	count(*)
	from	CuryRtTp (NOLOCK)
	where	RateTypeID = @RateTypeID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_RateTypeIDValid] TO [MSDSL]
    AS [dbo];


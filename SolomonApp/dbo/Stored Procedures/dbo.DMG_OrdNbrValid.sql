 create procedure DMG_OrdNbrValid
	@CpnyID	varchar(10),
	@OrdNbr	varchar(15)
as
	if (
	select	count(*)
	from	SOHeader (NOLOCK)
	where	CpnyID = @CpnyID
	and	OrdNbr = @OrdNbr
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



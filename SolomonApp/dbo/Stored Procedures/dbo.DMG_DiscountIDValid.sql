 create procedure DMG_DiscountIDValid
	@CpnyID		varchar(10),
	@DiscountID	varchar(1)
as
	if (
	select	count(*)
	from	SODiscCode (NOLOCK)
	where	CpnyID = @CpnyID
	and	DiscountID = @DiscountID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_DiscountIDValid] TO [MSDSL]
    AS [dbo];


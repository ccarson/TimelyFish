 create procedure DMG_SODiscCodeAcctSub
	@CpnyID		varchar(10),
	@DiscountID	varchar(1),
	@DiscAcct	varchar(10) OUTPUT,
	@DiscSub	varchar(31) OUTPUT
as
	select	@DiscAcct = DiscAcct,
		@DiscSub = DiscSub
	from	SODiscCode
	where	CpnyID = @CpnyID
	and	DiscountID = @DiscountID

	if @@ROWCOUNT = 0 begin
		set @DiscAcct = ''
		set @DiscSub = ''
		return 0	--Failure
	end
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SODiscCodeAcctSub] TO [MSDSL]
    AS [dbo];


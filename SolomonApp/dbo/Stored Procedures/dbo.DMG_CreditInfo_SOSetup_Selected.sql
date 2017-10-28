 create proc DMG_CreditInfo_SOSetup_Selected
	@CreditGraceDays	smallint OUTPUT,
	@CreditGracePct		decimal(25,9) OUTPUT
as
	select	@CreditGraceDays = CreditGraceDays,
		@CreditGracePct = CreditGracePct
	from	SOSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @CreditGraceDays = 0
		set @CreditGracePct = 0
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CreditInfo_SOSetup_Selected] TO [MSDSL]
    AS [dbo];


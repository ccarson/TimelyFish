 create proc DMG_CreditCheck_GetCreditCheck
	@CreditCheck smallint OUTPUT
as
	-- Set to 1 so credit checking defaults to true if the select below fails
	set @CreditCheck = 1

	select	@CreditCheck = CreditCheck
	from	SOSetup (NOLOCK)

	--select @CreditCheck



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CreditCheck_GetCreditCheck] TO [MSDSL]
    AS [dbo];


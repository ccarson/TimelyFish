 create procedure DMG_MultiCurrencyActivated
as
	declare @MCActivated as bit

	select	@MCActivated = MCActivated
	from	CMSetup (NOLOCK)

	if @@ROWCOUNT = 0 or @MCActivated = 0
		--select 0
		return 0	--Currency Manager is not installed or multi-currency is not activated
	else
		--select 1
		return 1



 create procedure DMG_PO_GetCurrencySetupSettings
	@APCuryOverride	bit OUTPUT,
	@APRtTpDflt	varchar(6) OUTPUT,
	@APRtTpOverride	bit OUTPUT
as
	select	@APCuryOverride = APCuryOverride,
		@APRtTpDflt = ltrim(rtrim(APRtTpDflt)),
		@APRtTpOverride = APRtTpOverride
	from	CMSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @APCuryOverride = 0
		set @APRtTpDflt = ''
		set @APRtTpOverride = 0
		--select 0
		return 0	--Currency Manager is not installed or multi-currency is not activated
	end
	else
		--select @ARCuryOverride, @ARRtTpDflt, @ARRtTpOverride, @ARPrcLvlRtTp
		return 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_GetCurrencySetupSettings] TO [MSDSL]
    AS [dbo];


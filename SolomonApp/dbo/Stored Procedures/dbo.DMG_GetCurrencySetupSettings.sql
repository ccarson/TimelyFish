 create procedure DMG_GetCurrencySetupSettings
	@ARCuryOverride	bit OUTPUT,
	@ARRtTpDflt	varchar(6) OUTPUT,
	@ARRtTpOverride	bit OUTPUT,
	@ARPrcLvlRtTp	varchar(6) OUTPUT
as
	select	@ARCuryOverride = ARCuryOverride,
		@ARRtTpDflt = ltrim(rtrim(ARRtTpDflt)),
		@ARRtTpOverride = ARRtTpOverride,
		@ARPrcLvlRtTp = ltrim(rtrim(ARPrcLvlRtTp))
	from	CMSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @ARCuryOverride = 0
		set @ARRtTpDflt = ''
		set @ARRtTpOverride = 0
		set @ARPrcLvlRtTp = ''
		--select 0
		return 0	--Currency Manager is not installed or multi-currency is not activated
	end
	else
		--select @ARCuryOverride, @ARRtTpDflt, @ARRtTpOverride, @ARPrcLvlRtTp
		return 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_GetCurrencySetupSettings] TO [MSDSL]
    AS [dbo];


 create proc DMG_GLSetup_PerInFiscalYr
	@PerInFiscalYr	smallint OUTPUT
as
	select	@PerInFiscalYr = NbrPer
	from	GLSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @PerInFiscalYr = 0
		return 0	--Failure
	end
	else
		--select @CPSOnOff
		return 1	--Success



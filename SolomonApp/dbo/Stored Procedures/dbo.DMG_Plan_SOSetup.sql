 create proc DMG_Plan_SOSetup
	@POAvailAtETA		smallint OUTPUT,
	@TransferAvailAtETA	integer OUTPUT,
	@WOAvailAtETA		smallint OUTPUT
as
	select	@POAvailAtETA = POAvailAtETA,
		@TransferAvailAtETA = S4Future09,
		@WOAvailAtETA = WOAvailAtETA
	from	SOSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @POAvailAtETA = 0
		set @TransferAvailAtETA = 0
		set @WOAvailAtETA = 0
		return 0	-- Failure
	end
	else
		return 1	-- Success



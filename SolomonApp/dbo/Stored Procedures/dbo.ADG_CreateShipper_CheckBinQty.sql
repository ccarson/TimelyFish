 create proc ADG_CreateShipper_CheckBinQty
as
	declare	@CheckBinQty	smallint
	declare	@POAvailAtETA	smallint
	declare	@TrfrAvailAtETA	smallint
	declare	@WOAvailAtETA	smallint

	select	@POAvailAtETA = POAvailAtETA,
		@TrfrAvailAtETA = S4Future09,
		@WOAvailAtETA = WOAvailAtETA
	from	SOSetup

	select	@POAvailAtETA = coalesce(@POAvailAtETA, 0)
	select	@TrfrAvailAtETA = coalesce(@TrfrAvailAtETA, 0)
	select	@WOAvailAtETA = coalesce(@WOAvailAtETA, 0)

	select	@CheckBinQty = 1

	if (@POAvailAtETA = 1)
		select @CheckBinQty = 0
	else
		if (@TrfrAvailAtETA = 1)
			select @CheckBinQty = 0
		else
			if (@WOAvailAtETA = 1)
				select @CheckBinQty = 0

	select	@CheckBinQty



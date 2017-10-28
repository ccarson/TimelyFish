 create proc ADG_Plan_SOSetup
as
	select	POAvailAtETA,
--		TransferAvailAtETA,
		S4Future09,		-- TransferAvailAtETA
		WOAvailAtETA

	from	SOSetup (nolock)



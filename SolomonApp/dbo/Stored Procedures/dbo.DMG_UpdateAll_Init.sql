 create proc DMG_UpdateAll_Init
	@ComputerName		varchar(21)
as
	delete from SOPlan
		delete from INUpdateQty_Wrk
	where ComputerName = @ComputerName



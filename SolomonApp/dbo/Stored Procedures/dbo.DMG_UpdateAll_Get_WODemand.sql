 create proc DMG_UpdateAll_Get_WODemand
as
	select		CpnyID, WONbr
	from		WOHeader
	where		Status not in ('P')		 	-- Not Purge
	order by	WONbr								-- For Demand cannot constrain on Proc Stage (PWOs)



 create proc DMG_UpdateAll_Get_WOSupply
as
	select		CpnyID, WONbr
	from		WOHeader
	where		ProcStage not in ('P','C') and		-- For supply, no plan/fin-closed WOs
	  		Status not in ('P')		 	-- Not Purge
	order by	WONbr



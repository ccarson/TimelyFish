 create proc DMG_UpdateAll_Get_PO
as
	select		CpnyID, PONbr
	from		Purchord
	where		Status in ('O', 'P')
	order by	PONbr



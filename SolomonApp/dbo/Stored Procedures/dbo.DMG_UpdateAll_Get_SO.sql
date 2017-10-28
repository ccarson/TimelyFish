 create proc DMG_UpdateAll_Get_SO
as
	select		CpnyID, OrdNbr
	from		SOHeader
	where		Status = 'O'
	order by	CpnyID, OrdNbr



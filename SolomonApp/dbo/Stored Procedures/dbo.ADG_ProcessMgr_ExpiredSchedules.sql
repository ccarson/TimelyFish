 create proc ADG_ProcessMgr_ExpiredSchedules @TodaysDate as smalldatetime
as
	select		h.CpnyID,
			h.OrdNbr
	from		SOHeader h inner join SOType t on t.CpnyId = h.CpnyId and t.SOTypeId = h.SOTypeId
	where		h.Status = 'O' and t.Behavior in('SO', 'WC', 'MO')
			and exists(select * from SOSched s where s.CpnyId = h.CpnyId and s.OrdNbr = h.OrdNbr and s.Status = 'O' and s.CancelDate <= @TodaysDate)



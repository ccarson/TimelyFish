 create procedure ADG_ProcessMgr_Priority_ID
	@ServerTimeStr	varchar(20)

as
	select		top 1 *
	from		ProcessQueue With (Index=ProcessQueue4)
	where		ProcessAt <= @ServerTimeStr
	order by	ProcessPriority,
			ProcessQueueID



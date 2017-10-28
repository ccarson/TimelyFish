 create proc ADG_ProcessMgr_Init
as
	select	*
	from	ProcessQueue
	where	ProcessType = ''



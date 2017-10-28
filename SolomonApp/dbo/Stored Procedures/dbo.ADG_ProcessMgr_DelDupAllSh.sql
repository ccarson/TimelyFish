 create proc ADG_ProcessMgr_DelDupAllSh
	@QueueID	int
as
	delete	from ProcessQueue
	where	ProcessQueueID <> @QueueID
	and	ProcessType = 'ALLSH'



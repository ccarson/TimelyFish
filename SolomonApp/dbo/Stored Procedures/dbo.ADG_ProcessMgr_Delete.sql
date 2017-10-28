 create proc ADG_ProcessMgr_Delete
	@QueueID	int
as
	delete	ProcessQueue
	where	ProcessQueueID = @QueueID



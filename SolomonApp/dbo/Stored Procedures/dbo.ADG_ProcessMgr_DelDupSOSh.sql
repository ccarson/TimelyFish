 create proc ADG_ProcessMgr_DelDupSOSh
	@QueueID	int,
	@CpnyID		varchar(10),
	@SOOrdNbr	varchar(15)
as
	delete	ProcessQueue
	where	ProcessQueueID <> @QueueID
	and	ProcessType = 'CRTSH'
	and	CpnyID = @CpnyID
	and	SOOrdNbr = @SOOrdNbr



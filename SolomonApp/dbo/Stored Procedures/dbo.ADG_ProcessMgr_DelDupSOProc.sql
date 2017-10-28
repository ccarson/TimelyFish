 create proc ADG_ProcessMgr_DelDupSOProc
	@QueueID	int,
	@CpnyID		varchar(10),
	@SOOrdNbr	varchar(15)
as
	delete	ProcessQueue
	where	ProcessQueueID <> @QueueID
	and	ProcessType = 'PRCSO'
	and	CpnyID = @CpnyID
	and	SOOrdNbr = @SOOrdNbr



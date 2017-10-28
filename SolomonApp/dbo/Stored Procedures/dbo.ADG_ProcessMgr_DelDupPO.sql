 create proc ADG_ProcessMgr_DelDupPO
	@QueueID	int,
	@CpnyID		varchar(10),
	@PONbr		varchar(10),
	@POLineRef	varchar(5)
as
	delete	from ProcessQueue
	where	ProcessQueueID <> @QueueID
	and	ProcessType = 'PLNPO'
	and	CpnyID = @CpnyID
	and	PONbr = @PONbr
	and	POLineRef like @POLineRef



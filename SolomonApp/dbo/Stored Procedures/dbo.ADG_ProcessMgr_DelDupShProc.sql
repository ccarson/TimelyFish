 create proc ADG_ProcessMgr_DelDupShProc
	@QueueID		int,
	@CpnyID			varchar(10),
	@SOShipperID		varchar(15)
as
	delete	ProcessQueue
	where	ProcessQueueID <> @QueueID
	and	ProcessType = 'PRCSH'
	and	CpnyID = @CpnyID
	and	SOShipperID = @SOShipperID



 create proc ADG_ProcessMgr_DelDupExSh
	@QueueID		int,
	@CpnyID			varchar(10),
	@SOShipperID		varchar(15),
	@SOShipperLineRef	varchar(5)
as
	delete	from ProcessQueue
	where	ProcessQueueID <> @QueueID
	and	ProcessType = 'PLNSH'
	and	CpnyID = @CpnyID
	and	SOShipperID = @SOShipperID
	and	SOShipperLineRef like @SOShipperLineRef



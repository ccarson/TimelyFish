 create proc ADG_ProcessMgr_DelDupUpdSh
	@QueueID	int,
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	delete	ProcessQueue
	where	ProcessQueueID <> @QueueID
	and	ProcessType = 'UPDSH'
	and	CpnyID = @CpnyID
	and	SOShipperID = @ShipperID



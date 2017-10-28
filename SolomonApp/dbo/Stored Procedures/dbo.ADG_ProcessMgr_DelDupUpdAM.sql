 create proc ADG_ProcessMgr_DelDupUpdAM
	@QueueID	int,
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	delete	ProcessQueue
	where	ProcessQueueID <> @QueueID
	and	ProcessType = 'UPDAM'
	and	CpnyID = @CpnyID
	and	SOShipperID = @ShipperID



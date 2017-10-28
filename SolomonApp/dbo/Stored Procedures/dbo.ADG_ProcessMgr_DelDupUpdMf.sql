 create proc ADG_ProcessMgr_DelDupUpdMf
	@QueueID	int,
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	delete	ProcessQueue
	where	ProcessQueueID <> @QueueID
	and	ProcessType = 'UPDMF'
	and	CpnyID = @CpnyID
	and	SOShipperID = @ShipperID



 create proc ADG_CreateShipper_InitSOShipM
as
	select	*
	from	SOShipMark
	where	CpnyID = '0'
	  and	ShipperID = '0'



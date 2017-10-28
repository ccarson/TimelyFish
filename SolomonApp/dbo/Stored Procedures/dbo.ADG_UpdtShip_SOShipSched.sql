 create proc ADG_UpdtShip_SOShipSched
	@CpnyID		varchar(10),
	@ShipperID	varchar(15),
	@ShipperLineRef	varchar(5),
	@OrdNbr		varchar(15),
	@OrdLineRef	varchar(5)
as
	select	OrdSchedRef,
		QtyPick

	from	SOShipSched

	where	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID
	  and	ShipperLineRef = @ShipperLineRef
	  and	OrdNbr = @OrdNbr
	  and	OrdLineRef = @OrdLineRef

	order by
		ReqDate,
		OrdSchedRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



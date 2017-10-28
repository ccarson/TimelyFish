 create proc ADG_UpdtShip_GetOrigQtyShip
	@CpnyID			varchar(10),
	@OrigShipperID		varchar(15),
	@OrigShipperLineRef 	varchar(5)
as
	select	QtyShip


	from	SOShipLine

	where	CpnyID = @CpnyID
	  and	ShipperID = @OrigShipperID
	  and 	LineRef = @OrigShipperLineRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



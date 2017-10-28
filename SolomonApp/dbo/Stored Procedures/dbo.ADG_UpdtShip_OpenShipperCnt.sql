 create proc ADG_UpdtShip_OpenShipperCnt
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@ShipperID	varchar(15)
as
	select	count(*)
	from	SOShipHeader
	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr
	  and	ShipperID <> @ShipperID
	  and	Status = 'O'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



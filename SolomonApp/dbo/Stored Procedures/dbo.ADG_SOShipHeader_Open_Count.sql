 create procedure ADG_SOShipHeader_Open_Count

	@CpnyID varchar(10),
	@OrdNbr varchar(15),
	@ShipperID varchar(15)
as

	select 	count(*)
	from	SOShipHeader
	where	CpnyID like @CpnyID
	  and	OrdNbr like @OrdNbr
	  and 	Status = 'O'
	  and	ShipperID <> @ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



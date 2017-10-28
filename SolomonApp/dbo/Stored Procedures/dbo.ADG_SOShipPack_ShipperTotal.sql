 create proc ADG_SOShipPack_ShipperTotal
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	select		sum(CuryFrtCost),
			sum(CuryFrtInvc),
			sum(FrtCost),
			sum(FrtInvc),
			sum(Wght)

	from		SOShipPack
	where		CpnyID = @CpnyID
	  and		ShipperID = @ShipperID
	group by	CpnyID,
			ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOShipPack_ShipperTotal] TO [MSDSL]
    AS [dbo];


 CREATE PROCEDURE DMG_SOShipLot_RMA_LotSerNbr
	@CpnyID		varchar (10),
	@ShipperID 	varchar (15),
	@LineRef	varchar (5),
	@LotSerNbr	varchar(25)
	AS
	select 	distinct LotSerNbr, Whseloc, QtyShip
	from 	SOShipLot
	where 	CpnyID = @CpnyID
	and 	ShipperID = @ShipperID
	and 	LineRef = @LineRef
	and	LotSerNbr like @LotSerNbr
	order by LotSerNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOShipLot_RMA_LotSerNbr] TO [MSDSL]
    AS [dbo];


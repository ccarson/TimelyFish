 create proc ADG_ShipTot_DelTax
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	delete		SOShipTax
	where		CpnyID = @CpnyID
	  and		ShipperID = @ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_ShipTot_DelTax] TO [MSDSL]
    AS [dbo];


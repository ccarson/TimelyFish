 create proc ADG_SONoShip_Delete
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15)
as
	delete	from SONoShip
	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



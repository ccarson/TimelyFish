 create proc ADG_SONoUpdate_Delete
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	delete	from SONoUpdate
	where	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



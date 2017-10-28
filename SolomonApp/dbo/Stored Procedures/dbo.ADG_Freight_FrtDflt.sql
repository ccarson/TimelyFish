 create proc ADG_Freight_FrtDflt
	@CpnyID		varchar(10),
	@ShipViaID	varchar(10)
as
	select	DfltFrtAmt,
		DfltFrtMthd
	from	ShipVia
	where	CpnyID = @CpnyID
	  and	ShipViaID = @ShipViaID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



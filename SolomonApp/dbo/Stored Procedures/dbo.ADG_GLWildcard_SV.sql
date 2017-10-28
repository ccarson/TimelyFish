 create proc ADG_GLWildcard_SV
	@CpnyID		varchar(10),
	@ShipViaID	varchar(15)
as
	select		FrtAcct,
			FrtSub
	from		ShipVia (nolock)
	where		CpnyID = @CpnyID
	  and		ShipViaID = @ShipViaID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



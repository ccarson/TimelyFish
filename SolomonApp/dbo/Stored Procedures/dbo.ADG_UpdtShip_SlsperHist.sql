 create proc ADG_UpdtShip_SlsperHist
	@SlsperID	varchar(10),
	@FiscYr		varchar(4)
as
	select	*
	from	SlsperHist
	where	SlsperID = @SlsperID
	  and	FiscYr = @FiscYr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



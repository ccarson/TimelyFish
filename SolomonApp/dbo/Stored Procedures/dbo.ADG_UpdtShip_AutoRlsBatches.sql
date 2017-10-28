 create proc ADG_UpdtShip_AutoRlsBatches
as
	select	convert(smallint, S4Future10)	-- AutoReleaseBatches
	from	SOSetup

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



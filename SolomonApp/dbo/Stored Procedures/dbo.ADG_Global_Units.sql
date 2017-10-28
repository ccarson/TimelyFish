 create procedure ADG_Global_Units

	@ToUnit varchar (6)
as
	select	distinct ToUnit
	from	INUnit
	where	UnitType = '1'
	and	ToUnit like @ToUnit
	order by ToUnit

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



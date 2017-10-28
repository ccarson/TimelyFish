 create proc ADG_Date_ClockDiff
	@DateTimeString	char(20)	-- format YYYYMMDD hh:mm[:ss:mm]
as
	select DateDiff(ss, @DateTimeString, GetDate())

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.
-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



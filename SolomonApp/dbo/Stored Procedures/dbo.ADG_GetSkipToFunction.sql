 create proc ADG_GetSkipToFunction
	@cpnyid			varchar(10),
	@sotypeid		varchar(4),
	@skipto			varchar(4)
as
	select	functionid,
		functionclass
	from	sostep
	where	cpnyid = @cpnyid
	  and	sotypeid = @sotypeid
	  and	seq >= @skipto
	  and	status <> 'D'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



 create proc ADG_GetEventType
	@cpnyid			varchar (10),
	@sotypeid		varchar (4),
	@currfunction		varchar (8),
	@currclass		varchar (4)
as
	-- For the given function and class, return the eventtype.
	select  eventtype
	from    sostep
	where   cpnyid = @cpnyid
	  and   sotypeid = @sotypeid
	  and   functionid = @currfunction
          and	functionclass = @currclass
	  and   eventtype <> 'X'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_GetEventType] TO [MSDSL]
    AS [dbo];


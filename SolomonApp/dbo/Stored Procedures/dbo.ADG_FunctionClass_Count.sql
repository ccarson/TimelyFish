 create proc ADG_FunctionClass_Count
	@cpnyid			varchar (10),
	@sotypeid		varchar (4),
	@currfunction		varchar (8),
	@currclass		varchar (4)
as
	-- Determine the Seq for the current function and class.
	select	count(*)
	from 	sostep
	where	cpnyid = @cpnyid
	  and	sotypeid = @sotypeid
	  and	functionid = @currfunction
	  and	functionclass = @currclass

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_FunctionClass_Count] TO [MSDSL]
    AS [dbo];


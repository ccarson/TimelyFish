 create proc ADG_GetNextFunctionClass
	@cpnyid			varchar (10),
	@sotypeid		varchar (4),
	@currfunction		varchar (8),
	@currclass		varchar (4)
as
	declare	@currseq	varchar (4)

	-- Determine the Seq for the current function and class.
	select	@currseq = seq
	from 	sostep
	where	cpnyid = @cpnyid
	  and	sotypeid = @sotypeid
	  and	functionid = @currfunction
	  and	functionclass = @currclass

	if @currseq IS NULL
	  select @currseq = ''

	-- Get the next non-disabled order step and return the function ID and class.
	select  functionid,
		functionclass
	from    sostep
	where   cpnyid = @cpnyid
	  and   sotypeid = @sotypeid
	  and   seq > @currseq
	  and   status <> 'D'
	order by
		seq

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



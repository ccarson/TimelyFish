 create proc ADG_POPrtQueue_DeleteRec
	@ri_id		smallint,
	@cpnyid		varchar(10),
	@PONbr		varchar(15)
as
	delete 	from POprintqueue
	where 	ri_id = @ri_id
	  and	CpnyID like @cpnyid
	  and	PONbr like @PONbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



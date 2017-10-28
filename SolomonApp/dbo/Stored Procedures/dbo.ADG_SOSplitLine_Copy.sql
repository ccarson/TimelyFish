 create proc ADG_SOSplitLine_Copy
	@cpnyid		varchar(10),
	@ordnbr		varchar(15),
	@lineref	varchar(5)
as
	select	CreditPct,
		NoteID,
		SlsperID
	from	SOSplitLine
	where	CpnyID = @cpnyid
	  and	OrdNbr = @ordnbr
	  and	LineRef = @lineref
	order by SlsperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOSplitLine_Copy] TO [MSDSL]
    AS [dbo];


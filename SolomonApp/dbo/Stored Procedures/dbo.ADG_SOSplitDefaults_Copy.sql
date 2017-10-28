 create proc ADG_SOSplitDefaults_Copy
	@cpnyid	varchar(10),
	@ordnbr	varchar(15)
as
	select	CreditPct,
		NoteID,
		SlsperID
	from	SOSplitDefaults
	where	CpnyID = @cpnyid
	  and	OrdNbr = @ordnbr
	order by SlsperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOSplitDefaults_Copy] TO [MSDSL]
    AS [dbo];


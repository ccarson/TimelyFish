 create proc DMG_COPostProcess
	@ri_id		smallint
as

	update 	POReqHdr
	set	COPrinted = 1
	from	POPrintQueue q, POReqHdr h
	where	q.ReqNbr = h.ReqNbr
	  and	q.ReqCntr = h.ReqCntr
	  and	q.RI_ID = @ri_id

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_COPostProcess] TO [MSDSL]
    AS [dbo];


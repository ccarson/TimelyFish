 create proc ADG_SOVoidInvc_Delete
	@CpnyID		varchar( 10 ),
	@ReportName	varchar( 30 ),
	@InvcNbr	varchar( 15 )

as
	delete from SOVoidInvc
	where	CpnyID = @CpnyID
	  and	ReportName = @ReportName
	  and 	InvcNbr = @InvcNbr
	  and 	ShipRegisterID = ''

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOVoidInvc_Delete] TO [MSDSL]
    AS [dbo];


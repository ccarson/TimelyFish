 create proc ADG_SOPrintCounters_Update
	@CpnyID		varchar( 10 ),
	@ReportName	varchar( 30 ),
	@NextInvoiceNbr varchar( 10 )
as

	Declare @RecCount	float

	select 	@RecCount = Count(*)
	from 	soprintcounters
	where	CpnyID like @CpnyID
	  and	ReportName like @ReportName

	If @RecCount = 0
		Insert 	SOPrintCounters
			(CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, LUpd_DateTime, LUpd_Prog,
			LUpd_User, NextInvcNbr, NoteID, ReportName, S4Future01, S4Future02,
			S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08,
			S4Future09, S4Future10, S4Future11, S4Future12, User1, User10,
			User2, User3, User4, User5, User6, User7, User8, User9)
		Values
			(@CpnyID, GETDATE(), 'SQL', 'SQL', GETDATE(), 'SQL',
			'SQL', @NextInvoiceNbr, 0, @ReportName, '', '',
			0, 0, 0, 0, '', '',
			0, 0, '', '', '', '',
			'', '', '', 0, 0, '', '', '')
	else
		update	SOPrintCounters
		set	NextInvcNbr = @NextInvoiceNbr,
			LUpd_DateTime = GETDATE()
		where	CpnyID like @CpnyID
		  and	ReportName like @ReportName

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



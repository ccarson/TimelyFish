 create proc ADG_SOVoidInvc_Insert
	@CpnyID		varchar( 10 ),
	@Crtd_Prog	varchar( 8 ),
	@Crtd_User	varchar( 10 ),
	@InvcNbr	varchar( 15 ),
	@ReportName	varchar( 30 ),
	@ShipRegisterID	varchar( 10 ),
	@VoidType	varchar( 1 )

as
	if (select count(*) from SOVoidInvc where CpnyID = @CpnyID and InvcNbr = @InvcNbr) = 0
	insert	SOVoidInvc
		(CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
		InvcNbr, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID, ReportName,
		S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
		S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
		S4Future11, S4Future12, ShipRegisterID, User1, User10, User2,
		User3, User4, User5, User6, User7, User8, User9, VoidType)
	values	(@CpnyID, GETDATE(), @Crtd_Prog, @Crtd_User,
		@InvcNbr, GETDATE(), @Crtd_Prog, @Crtd_User, 0, @ReportName,
		'', '', 0, 0, 0,
		0, '', '', 0, 0,
		'', '', @ShipRegisterID, '', '', '',
		'', '', 0, 0, '', '', '', @VoidType)
	-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOVoidInvc_Insert] TO [MSDSL]
    AS [dbo];


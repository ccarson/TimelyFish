 CREATE PROCEDURE DMG_SOStep_Insert_REL

	@Auto 		smallint,
	@CpnyID		varchar(10),
	@CreditChk	smallint,
	@CreditChkProg	smallint,
	@NotesOn	smallint,
	@RptProg	smallint,
	@SkipTo		varchar(4),
	@SOTypeID	varchar(4),
	@Status		varchar(1)

as
	exec DMG_SOStep_Insert
		@Auto,		'',		'',	'ADG_AutoRelease_Order',
		@CpnyID,	@CreditChk,	@CreditChkProg,	'Release Order',
		'REL',		'0200',		'4010000',	@NotesOn,
		'',		@RptProg,	'0110',		@SkipTo,
		@SOTypeID,	@Status

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOStep_Insert_REL] TO [MSDSL]
    AS [dbo];


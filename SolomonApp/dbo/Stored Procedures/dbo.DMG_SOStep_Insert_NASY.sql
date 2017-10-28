 CREATE PROCEDURE DMG_SOStep_Insert_NASY

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
		@Auto,		'',		'4065100',	'',
		@CpnyID,	@CreditChk,	@CreditChkProg,	'Print Assembly Notification',
		'NASY',		'',		'4065100',	@NotesOn,
		'',		@RptProg,	'0430',		@SkipTo,
		@SOTypeID,	@Status

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOStep_Insert_NASY] TO [MSDSL]
    AS [dbo];


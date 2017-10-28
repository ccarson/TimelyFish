 CREATE PROCEDURE DMG_SOStep_Insert_RUPD

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
		@Auto,		'',		'',	'ADG_Release_for_Update',
		@CpnyID,	@CreditChk,	@CreditChkProg,	'Release for Update',
		'RUPD',		'0100',		'4043000',	@NotesOn,
		'',		@RptProg,	'0800',		@SkipTo,
		@SOTypeID,	@Status

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOStep_Insert_RUPD] TO [MSDSL]
    AS [dbo];


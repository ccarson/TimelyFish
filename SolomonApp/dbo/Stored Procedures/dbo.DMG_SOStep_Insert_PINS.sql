 CREATE PROCEDURE DMG_SOStep_Insert_PINS

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
		@Auto,		'',		'4064000',	'',
		@CpnyID,	@CreditChk,	@CreditChkProg,	'Print Inspection Order',
		'PINS',		'',		'4064000',	@NotesOn,
		'',		@RptProg,	'0510',		@SkipTo,
		@SOTypeID,	@Status

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



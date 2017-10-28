 CREATE PROCEDURE DMG_SOStep_Insert_CASY

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
		@Auto,		'',		'',		'',
		@CpnyID,	@CreditChk,	@CreditChkProg,	'Confirm Assembly',
		'CASY',		'0250',		'4011000',	@NotesOn,
		'',		@RptProg,	'0420',		@SkipTo,
		@SOTypeID,	@Status

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



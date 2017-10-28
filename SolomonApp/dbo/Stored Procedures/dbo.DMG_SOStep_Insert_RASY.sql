 CREATE PROCEDURE DMG_SOStep_Insert_RASY

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
		@Auto,		'',		'',	'ADG_Release_for_Assembly',
		@CpnyID,	@CreditChk,	@CreditChkProg,	'Release for Assembly',
		'RASY',		'0200',		'4011000',	@NotesOn,
		'',		@RptProg,	'0400',		@SkipTo,
		@SOTypeID,	@Status

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



 CREATE PROCEDURE DMG_SOStep_Insert_PSHP

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
		@Auto,		'',		'4067000',	'',
		@CpnyID,	@CreditChk,	@CreditChkProg,	'Print Bill of Lading',
		'PSHP',		'',		'4067000',	@NotesOn,
		'',		@RptProg,	'0710',		@SkipTo,
		@SOTypeID,	@Status

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



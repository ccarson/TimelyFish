 CREATE PROCEDURE DMG_SOStep_Insert_GPOS

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
		@Auto,		'',		'6040000',		'',
		@CpnyID,	@CreditChk,	@CreditChkProg,	'Generate POs needed',
		'GPO',		'0000',		'6040000',	@NotesOn,
		'',		@RptProg,	'0215',		@SkipTo,
		@SOTypeID,	@Status

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOStep_Insert_GPOS] TO [MSDSL]
    AS [dbo];


 -- Insert a 'X' step on advanced shipment management
CREATE PROCEDURE DMG_SOStep_Insert_ASM

	@Auto 		smallint,
	@AutoPGMClass	varchar(4),
	@AutoPgmID	Varchar(8),
	@CpnyID		varchar(10),
	@CreditChk	smallint,
	@CreditChkProg	smallint,
	@Descr		Varchar(30),
	@FunctionClass	varchar(4),
	@FunctionID	varchar(8),
	@NotesOn	smallint,
	@RptProg	smallint,
	@Seq		varchar(4),
	@SkipTo		varchar(4),
	@SOTypeID	varchar(4),
	@Status		varchar(1)

as
	exec DMG_SOStep_Insert
		@Auto,		@AutoPgmClass,	@AutoPgmID,	'',
		@CpnyID,	@CreditChk,	@CreditChkProg,	@Descr,
		'X',		@FunctionClass,	@FunctionID,	@NotesOn,
		'',		@RptProg,	@Seq,		@SkipTo,
		@SOTypeID,	@Status

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOStep_Insert_ASM] TO [MSDSL]
    AS [dbo];


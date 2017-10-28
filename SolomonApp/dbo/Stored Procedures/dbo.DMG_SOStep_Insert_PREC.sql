 CREATE PROCEDURE DMG_SOStep_Insert_PREC

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
		@Auto,		'',		'4064500',		'',
		@CpnyID,	@CreditChk,	@CreditChkProg,	'Print Receiver',
		'PREC',		'',		'4064500',	@NotesOn,
		'',		@RptProg,	'0314',		@SkipTo,
		@SOTypeID,	@Status

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOStep_Insert_PREC] TO [MSDSL]
    AS [dbo];


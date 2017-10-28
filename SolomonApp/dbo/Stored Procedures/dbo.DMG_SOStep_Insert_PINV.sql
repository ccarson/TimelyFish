 CREATE PROCEDURE DMG_SOStep_Insert_PINV

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
	declare @seq varchar(4)

	if @SOTypeID = 'CS' or @SOTypeID = 'WC'
		select @seq = '0790'
	else
		select @seq = '0820'

	exec DMG_SOStep_Insert
		@Auto,		'',		'4068000',	'',
		@CpnyID,	@CreditChk,	@CreditChkProg,	'Print Invoice',
		'PINV',		'',		'4068000',	@NotesOn,
		'',		@RptProg,	@seq,		@SkipTo,
		@SOTypeID,	@Status

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOStep_Insert_PINV] TO [MSDSL]
    AS [dbo];


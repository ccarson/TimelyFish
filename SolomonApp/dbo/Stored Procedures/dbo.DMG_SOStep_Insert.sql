 CREATE PROCEDURE DMG_SOStep_Insert

	@Auto smallint,			@AutoPgmClass varchar(4),	@AutoPgmID varchar(8),		@AutoProc varchar(30),
	@CpnyID varchar(10),		@CreditChk smallint,		@CreditChkProg smallint,	@Descr varchar(30),
	@EventType varchar(4),		@FunctionClass varchar(4),	@FunctionID varchar(8),		@NotesOn smallint,
	@Prompt varchar(40),		@RptProg smallint,		@Seq varchar(4),		@SkipTo varchar(4),
	@SOTypeID varchar(4),		@Status varchar(1)

as
	declare @Today smalldatetime

	select @Today = convert(smalldatetime, getdate())

	Insert Into SOStep(
		Auto,		AutoPgmClass,	AutoPgmID,	AutoProc,	CpnyID,
		CreditChk,	CreditChkProg,	Crtd_DateTime,	Crtd_Prog,	Crtd_User,
		Descr,		EventType,	FunctionClass,	FunctionID,	LanguageID,
		LUpd_DateTime,	LUpd_Prog,	LUpd_User,	NoteID,		NotesOn,
		Prompt,		RptProg,	S4Future01,	S4Future02,	S4Future03,
		S4Future04,	S4Future05,	S4Future06,	S4Future07,	S4Future08,
		S4Future09,	S4Future10,	S4Future11,	S4Future12,	Seq,
		SkipTo,		SOTypeID,	Status,		User1,		User10,
		User2,		User3,		User4,		User5,		User6,
		User7,		User8,		User9)
	values(
		@Auto,		@AutoPgmClass,	@AutoPgmID,	@AutoProc,	@CpnyID,
		@CreditChk,	@CreditChkProg,	@Today,		'40200',	'SYSADMIN',
		@Descr,		@EventType,	@FunctionClass,	@FunctionID,	'',
		@Today,		'40200',	'SYSADMIN',	0,		@NotesOn,
		@Prompt,	@RptProg,	'',		'',		0,
		0,		0,		0,		'',	'',
		0,		0,		'',		'',		@Seq,
		@SkipTo,	@SOTypeID,	@Status,	'',		'',
		'',		'',		'',		0,		0,
		'',		'',		'')

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



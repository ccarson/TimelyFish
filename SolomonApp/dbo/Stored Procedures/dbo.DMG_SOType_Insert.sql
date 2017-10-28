 CREATE PROCEDURE DMG_SOType_Insert

	@Active smallint,		@ARAcct varchar(10),		@ARSub varchar(31),		@AutoReleaseReturns smallint,
	@Behavior varchar(4),		@CancelDays smallint,		@COGSAcct varchar(10),		@COGSSub varchar(31),
	@CpnyID varchar(10),		@Descr varchar(30),		@DiscAcct varchar(10),		@DiscSub varchar(31),
	@Disp varchar(3),		@EnterLotSer smallint,		@FrtAcct varchar(10),		@FrtSub varchar(31),
	@InvAcct varchar(10),		@InvcNbrPrefix varchar(15),	@InvcNbrType varchar(4),	@InvSub varchar(31),
	@LastInvcNbr varchar(10),	@LastOrdNbr varchar(10),	@LastShipperNbr varchar(10),	@MiscAcct varchar(10),
	@MiscSub varchar(31),		@NoAutoCreateShippers smallint,	@OrdNbrPrefix varchar(15),	@OrdNbrType varchar(4),
	@RequireDetailAppr smallint,	@RequireManRelease smallint,	@RequireTechAppr smallint,	@ReturnOrderTypeID varchar(4),
	@ShipperPrefix varchar(15),	@ShipperType varchar(4),	@ShiptoType varchar(1),		@SlsAcct varchar(10),
	@SlsSub varchar(31),		@SOTypeID varchar(4),		@StdOrdType smallint,		@WholeOrdDiscAcct varchar(10),
	@WholeOrdDiscSub varchar(31), @InvcNbrAR smallint,  @AssemblyOnSat smallint, @AssemblyOnSun smallint

as
	declare @Today smalldatetime

	select @Today = convert(smalldatetime, getdate())

	Insert Into SOType(
		Active,			ARAcct,			ARSub,			AssemblyOnSat,   AssemblyOnSun, AutoReleaseReturns,
		Behavior,		CancelDays,		COGSAcct,		COGSSub,
		CpnyID,			Crtd_DateTime,		Crtd_Prog,		Crtd_User,
		Descr,			DiscAcct,		DiscSub,		Disp,
		EnterLotSer,		FrtAcct,		FrtSub,			InvAcct,
		InvcNbrPrefix,		InvcNbrType,		InvSub,			LastInvcNbr,
		LastOrdNbr,		LastShipperNbr,		LUpd_DateTime,		LUpd_Prog,
		LUpd_User,		MiscAcct,		MiscSub,		NoAutoCreateShippers,
		NoteID,			OrdNbrPrefix,		OrdNbrType,		RequireDetailAppr,
		RequireManRelease,	RequireTechAppr,	ReturnOrderTypeID,	S4Future01,
		S4Future02,		S4Future03,		S4Future04,		S4Future05,
		S4Future06,		S4Future07,		S4Future08,		S4Future09,
		S4Future10,		S4Future11,		S4Future12,		ShipperPrefix,
		ShipperType,		ShiptoType,		SlsAcct,		SlsSub,
		SOTypeID,		StdOrdType,		User1,			User10,
		User2,			User3,			User4,			User5,
		User6,			User7,			User8,			User9,
		WholeOrdDiscAcct,	WholeOrdDiscSub, InvcNbrAR)

	values(
		@Active,		@ARAcct,		@ARSub,			@AssemblyOnSat,  @AssemblyOnSun,  @AutoReleaseReturns,
		@Behavior,		@CancelDays,		@COGSAcct,		@COGSSub,
		@CpnyID,		@Today,			'40200',		'SYSADMIN',
		@Descr,			@DiscAcct,		@DiscSub,		@Disp,
		@EnterLotSer,		@FrtAcct,		@FrtSub,		@InvAcct,
		@InvcNbrPrefix,		@InvcNbrType,		@InvSub,		@LastInvcNbr,
		@LastOrdNbr,		@LastShipperNbr,	@Today,			'40200',
		'SYSADMIN',		@MiscAcct,		@MiscSub,		@NoAutoCreateShippers,
		0,			@OrdNbrPrefix,		@OrdNbrType,		@RequireDetailAppr,
		@RequireManRelease,	@RequireTechAppr,	@ReturnOrderTypeID,	'',
		'',			0,			0,			0,
		0,			'',			'',			0,
		0,			'',			'',			@ShipperPrefix,
		@ShipperType,		@ShiptoType,		@SlsAcct,		@SlsSub,
		@SOTypeID,		@StdOrdType,		'',			'',
		'',			'',			'',			0,
		0,			'',			'',			'',
		@WholeOrdDiscAcct,	@WholeOrdDiscSub, @InvcNbrAR)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



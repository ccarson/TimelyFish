 create procedure ADG_ProcessMgr_QueueSHProcess2
	@CpnyID		varchar(10),
	@ShipperID	varchar(15),
	@LineRef	varchar(5),
	@ComputerName	varchar(21),
	@Crtd_Prog as varchar(8),
	@Crtd_User as varchar(10)
as
	declare	@DelayMins		smallint
	declare	@ProcessPriority	smallint
	declare	@ProcessType		varchar(5)

	select	@DelayMins = 0

	select	@ProcessPriority	= 255
	select	@ProcessType		= 'PRCSH'

	insert ProcessQueue
	(
	ComputerName, CpnyID, CreateShipper, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CustID,InvtID, LUpd_DateTime, LUpd_Prog, LUpd_User,
	MaintMode, NoteID, POLineRef, PONbr, ProcessAt,
	ProcessPriority, ProcessType,
	S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
	S4Future11, S4Future12, SiteID, SOLineRef, SOOrdNbr,
	SOSchedRef, SOShipperID, SOShipperLineRef, User1, User10,
	User2, User3, User4, User5, User6,
	User7, User8, User9
	)

	values
	(
	@ComputerName, @CpnyID, 0, getdate(), @Crtd_Prog, @Crtd_User,
	'', '', getdate(), 'REQUEUE', @Crtd_User,
	0, 0, '', '', 0,
	@ProcessPriority, @ProcessType,
	'', '', 0, 0, 0,
	0, '', '', 0, 0,
	'', '', '', '', '',
	'', @ShipperID, @LineRef, '', '',
	'', '', '', 0, 0,
	'', '', ''
	)



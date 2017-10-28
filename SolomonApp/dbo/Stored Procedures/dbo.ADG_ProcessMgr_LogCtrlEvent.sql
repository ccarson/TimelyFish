 create proc ADG_ProcessMgr_LogCtrlEvent
	@EventType	varchar(5),	-- 'START', 'STOP', etc.
	@ComputerName	varchar(20)
as
	insert ProcessLog
	(
	ComputerName, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CustID, InvtID, LogDateTime, LUpd_DateTime, LUpd_Prog, LUpd_User,
	MaintMode, NoteId, POLineRef, PONbr, ProcessAt,
	ProcessPriority, ProcessQueueID, ProcessType, S4Future01, S4Future02,
	S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
	S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
	SiteID, SOLineRef, SOOrdNbr, SOSchedRef, SOShipperID,
	SOShipperLineRef, User1, User10, User2, User3,
	User4, User5, User6, User7, User8,
	User9
	)

	values
	(
	@ComputerName, '', '', '', '',
	'', '', getdate(), '', '', '',
	0, 0, '', '', '',
	0, 0, @EventType, '', '',
	0, 0, 0, 0, '',
	'', 0, 0, '', '',
	'', '', '', '', '',
	'', '', '', '', '',
	'', 0, 0, '', '',
	''
	)



 create proc ADG_ProcessMgr_DelLog
	@CutoffDate	smalldatetime
as
	delete	ProcessLog
	where	LogDateTime < @CutoffDate



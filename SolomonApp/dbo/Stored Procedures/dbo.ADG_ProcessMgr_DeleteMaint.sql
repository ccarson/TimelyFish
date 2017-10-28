 create proc ADG_ProcessMgr_DeleteMaint
as
	delete	ProcessQueue
	where	MaintMode = 1



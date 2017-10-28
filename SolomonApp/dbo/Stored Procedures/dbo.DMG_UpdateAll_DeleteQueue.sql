 create proc DMG_UpdateAll_DeleteQueue
as
	delete
	from		ProcessQueue
	where		ProcessCPSOff = 1 and
			ProcessType <> 'MAINT'



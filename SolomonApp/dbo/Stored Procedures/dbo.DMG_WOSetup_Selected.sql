 create proc DMG_WOSetup_Selected
AS
	select	Mfg_Task,
		WOPendingProject,
		S4Future12			-- Print WO Batch Reports

	from	WOSetUp

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_WOSetup_Selected] TO [MSDSL]
    AS [dbo];


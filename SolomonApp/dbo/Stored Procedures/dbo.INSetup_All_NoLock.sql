 /****** Object:  Stored Procedure dbo.INSetup_All_NoLock    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INSetup_All_NoLock    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INSetup_All_NoLock as
    Select * from INSetup(NoLock) order by SetupId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INSetup_All_NoLock] TO [MSDSL]
    AS [dbo];


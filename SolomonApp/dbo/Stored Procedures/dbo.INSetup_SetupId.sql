 /****** Object:  Stored Procedure dbo.INSetup_SetupId    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INSetup_SetupId    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INSetup_SetupId @parm1 varchar ( 2) as
    Select * from INSetup where SetupId = @parm1 order by SetupId



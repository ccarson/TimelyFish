 /****** Object:  Stored Procedure dbo.APSetup_SetupId    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure APSetup_SetupId @parm1 varchar ( 2) as
Select * from APSetup where SetupId like @parm1 order by SetupId



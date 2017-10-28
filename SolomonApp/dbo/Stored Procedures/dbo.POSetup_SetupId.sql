 /****** Object:  Stored Procedure dbo.POSetup_SetupId    Script Date: 4/16/98 7:50:26 PM ******/
Create Procedure POSetup_SetupId @parm1 varchar ( 2) as
Select * from POSetup where SetupId like @parm1 order by SetupId



 /****** Object:  Stored Procedure dbo.CASetup_SetupId    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CASetup_SetupId @parm1 varchar ( 2) as
       Select * from CASetup
           where SetupId like @parm1
           order by SetupId



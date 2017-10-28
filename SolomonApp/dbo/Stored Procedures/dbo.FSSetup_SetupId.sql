 /****** Object:  Stored Procedure dbo.FSSetup_SetupId    Script Date: 4/7/98 12:45:04 PM ******/
Create Proc FSSetup_SetupId @parm1 varchar ( 2) as
       Select * from FSSetup
           where SetupId like @parm1
           order by SetupId




GO
GRANT CONTROL
    ON OBJECT::[dbo].[FSSetup_SetupId] TO [MSDSL]
    AS [dbo];


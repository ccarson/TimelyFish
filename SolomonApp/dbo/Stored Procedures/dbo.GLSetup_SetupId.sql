 /****** Object:  Stored Procedure dbo.GLSetup_SetupId    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc GLSetup_SetupId @parm1 varchar ( 2) as
       Select * from GLSetup
           where SetupId like @parm1
           order by SetupId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLSetup_SetupId] TO [MSDSL]
    AS [dbo];


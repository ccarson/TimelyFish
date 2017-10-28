 /****** Object:  Stored Procedure dbo.ARSetup_SetupId    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc ARSetup_SetupId @parm1 varchar ( 2) as
    Select * from ARSetup where setupid like @parm1 order by SetupId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARSetup_SetupId] TO [MSDSL]
    AS [dbo];


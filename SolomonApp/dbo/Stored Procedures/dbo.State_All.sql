 /****** Object:  Stored Procedure dbo.State_All    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc State_All @parm1 varchar ( 3) as
    Select * from State where StateProvId like @parm1 order by StateProvId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[State_All] TO [MSDSL]
    AS [dbo];


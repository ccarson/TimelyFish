 Create Procedure  WorkLoc_sall @parm1 varchar ( 6) as
       Select * from WorkLoc
           where WrkLocId LIKE @parm1
           order by WrkLocId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WorkLoc_sall] TO [MSDSL]
    AS [dbo];


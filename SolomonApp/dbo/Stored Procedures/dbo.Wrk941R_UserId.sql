 Create Proc  Wrk941R_UserId @parm1 varchar ( 47) as
       Select * From Wrk941R
           where UserId  =  @parm1
           order by UserId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Wrk941R_UserId] TO [MSDSL]
    AS [dbo];


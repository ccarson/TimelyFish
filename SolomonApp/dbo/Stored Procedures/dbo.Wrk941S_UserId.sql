 Create Proc  Wrk941S_UserId @parm1 varchar ( 47) as
       Select * From Wrk941S
           where UserId  =  @parm1
           order by UserId,
                    ChkDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Wrk941S_UserId] TO [MSDSL]
    AS [dbo];


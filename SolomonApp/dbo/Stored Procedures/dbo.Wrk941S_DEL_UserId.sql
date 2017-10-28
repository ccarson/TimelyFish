 Create Proc  Wrk941S_DEL_UserId @parm1 varchar ( 47) as
       Delete wrk941s from Wrk941S
           where UserId   =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Wrk941S_DEL_UserId] TO [MSDSL]
    AS [dbo];


 Create Proc  Wrk941R_DEL_UserId @parm1 varchar ( 47) as
       Delete wrk941r from Wrk941R
           where UserId   =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Wrk941R_DEL_UserId] TO [MSDSL]
    AS [dbo];


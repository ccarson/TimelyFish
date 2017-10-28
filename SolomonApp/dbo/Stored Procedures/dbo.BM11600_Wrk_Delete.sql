 Create Proc BM11600_Wrk_Delete @parm1 varchar (47), @parm2 varchar (5) as
            Delete from BM11600_Wrk where
		LUpd_User = @parm1 and
		LUpd_Prog = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BM11600_Wrk_Delete] TO [MSDSL]
    AS [dbo];


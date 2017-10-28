 /****** Object:  Stored Procedure dbo.INTran_PerEnt_PerPost    Script Date: 4/17/98 10:58:17 AM ******/
/****** Object:  Stored Procedure dbo.INTran_PerEnt_PerPost    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc INTran_PerEnt_PerPost @parm1 varchar ( 6), @parm2 varchar ( 6) as
    Select * from INTran
        where (INtran.PerEnt = @parm1 or INTran.PerPost = @parm2)
                and INTRan.Rlsed = 1 order by BatNbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_PerEnt_PerPost] TO [MSDSL]
    AS [dbo];


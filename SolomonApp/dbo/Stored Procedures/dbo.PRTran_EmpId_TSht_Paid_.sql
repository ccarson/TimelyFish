 Create Proc PRTran_EmpId_TSht_Paid_ @parm1 varchar ( 10), @parm2 smallint, @parm3 smallint as
        Select * from PRTran
           where EmpId      = @parm1
             and TimeShtFlg = @parm2
             and Paid       = @parm3
           order by EmpId,
                    TimeShtFlg,
                    Rlsed,
                    Paid,
                    WrkLocId,
                    EarnDedId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_EmpId_TSht_Paid_] TO [MSDSL]
    AS [dbo];


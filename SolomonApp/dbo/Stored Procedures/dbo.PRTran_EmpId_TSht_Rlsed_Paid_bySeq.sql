 CREATE PROC PRTran_EmpId_TSht_Rlsed_Paid_bySeq
@EmpID varchar ( 10),
@Tsht  smallint,
@Rlsed smallint,
@Paid  smallint
AS
       Select * from PRTran
           where EmpId       =  @EmpID
             and TimeShtFlg  =  @Tsht
             and Rlsed       =  @Rlsed
             and Paid        =  @Paid
           order by EmpId,
                    TimeShtFlg,
                    Rlsed,
                    Paid,
                    ChkSeq,
                    EarnDedId,
                    WrkLocId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_EmpId_TSht_Rlsed_Paid_bySeq] TO [MSDSL]
    AS [dbo];


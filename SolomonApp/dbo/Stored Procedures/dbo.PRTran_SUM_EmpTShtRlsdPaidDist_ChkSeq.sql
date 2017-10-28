 Create Proc PRTran_SUM_EmpTShtRlsdPaidDist_ChkSeq
@parm1  varchar (10),
@parm2  smallint,
@parm3  smallint,
@parm4  smallint,
@parm5  varchar (1),
@ChkSeq varchar (2)
AS
Select SUM(Qty)
from PRTran
where EmpId           =  @parm1
      and TimeShtFlg  =  @parm2
      and Rlsed       =  @parm3
      and Paid        =  @parm4
      and Dist        =  @parm5
      and ChkSeq      =  @ChkSeq



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_SUM_EmpTShtRlsdPaidDist_ChkSeq] TO [MSDSL]
    AS [dbo];


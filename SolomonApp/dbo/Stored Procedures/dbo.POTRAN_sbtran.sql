 create procedure  POTRAN_sbtran @parm1 varchar (6), @parm2 varchar (10)   as
select *
from  POTRAN, PJ_ACCOUNT, PORECEIPT
where  POTRAN.perpost =  @parm1 and
POTRAN.batnbr = @parm2 and
POTRAN.pc_status =  '1' and
POTRAN.acct =  PJ_ACCOUNT.gl_acct and
POTran.rcptnbr = POReceipt.rcptnbr and
POReceipt.rlsed = 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POTRAN_sbtran] TO [MSDSL]
    AS [dbo];


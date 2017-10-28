 create procedure INTRAN_sbtran @parm1 varchar (6), @parm2 varchar (10)   as
select INTRAN.*, PJ_ACCOUNT.*, INVENTORY.descr
from   INTRAN, PJ_ACCOUNT, INVENTORY
where
INTRAN.pc_status = '1' and
INTRAN.perpost =  @parm1 and
INTRAN.batnbr = @parm2 and
INTRAN.rlsed =  1 and
( (INTRAN.jrnltype = 'IN' and INTRAN.acct = PJ_ACCOUNT.gl_acct)
   or
  (INTRAN.jrnltype = 'OM' and INTRAN.trantype <> 'CG' and INTRAN.cogsacct = PJ_ACCOUNT.gl_acct) ) and
INTRAN.invtid = INVENTORY.invtid



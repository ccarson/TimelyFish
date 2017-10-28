 create procedure  GLTRAN_stran @parm1 varchar (6)   as
select *
from  GLTRAN, BATCH, PJ_ACCOUNT
where     GLTRAN.perpost =  @parm1 and
GLTRAN.rlsed =  1 and
GLTRAN.pc_status =  '1' and
(GLTRAN.module = 'GL' or GLTRAN.module = 'CA' or GLTRAN.module = 'TE') and
GLTRAN.batnbr =  BATCH.batnbr and
GLTRAN.module =  BATCH.module and
GLTRAN.acct = PJ_ACCOUNT.gl_acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTRAN_stran] TO [MSDSL]
    AS [dbo];


 create procedure PJ_INVEN_sstat @parm1 varchar (6)   as
select *
from  PJ_INVEN, INTRAN, PJ_ACCOUNT
where PJ_INVEN.status_pa =  ' ' and
PJ_INVEN.prim_key = INTRAN.user2 and
INTRAN.perpost =  @parm1 and
INTRAN.rlsed =  1 and
INTRAN.acct = PJ_ACCOUNT.gl_acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJ_INVEN_sstat] TO [MSDSL]
    AS [dbo];


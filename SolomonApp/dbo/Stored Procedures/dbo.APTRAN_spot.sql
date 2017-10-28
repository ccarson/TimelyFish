 create procedure  APTRAN_spot
as
select *
from  APTRAN, APDOC, PJ_ACCOUNT
where     APTRAN.pc_status = '1' and
APTRAN.rlsed     = 0 and
APTRAN.JrnlType = 'PO' and
APTRAN.refnbr   = APDOC.refnbr and
APTRAN.batnbr   = APDOC.batnbr and
APDOC.DocType   = 'VO' and
APTRAN.acct     = PJ_ACCOUNT.gl_acct



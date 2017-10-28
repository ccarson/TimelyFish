 create procedure  APTRAN_spostatm as
select APTRAN.*,
       APDOC.*,
       PJ_ACCOUNT.*,
       PURCHORD.ponbr,
       PURCHORD.status
from  APTRAN, APDOC, PJ_ACCOUNT, PURCHORD
where APTRAN.pc_status = '1' and
APTRAN.rlsed = 0 and
APTRAN.lineid <> 0 and
APTRAN.refnbr   = APDOC.refnbr and
APTRAN.batnbr   = APDOC.batnbr and
APDOC.DocType   = 'VO' and
apdoc.rlsed = 0 and
apdoc.ponbr = purchord.ponbr and
purchord.status = 'M' and
APTRAN.acct     = PJ_ACCOUNT.gl_acct
order by aptran.pc_status, aptran.rlsed, aptran.jrnltype



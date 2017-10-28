 create procedure  APTRAN_ssvpo @parm1 varchar (10) , @parm2 varchar (05)   as
SELECT *
FROM      APDOC, APTRAN, PJ_ACCOUNT
WHERE     APDOC.PONbr   =  @parm1 and
APTRAN.batnbr =  APDOC.batnbr and
APTRAN.refnbr =  APDOC.refnbr and
APTRAN.POLineRef =  @parm2 and
APTRAN.rlsed  =  1 and
APTRAN.pc_status  =  '2' and
APTRAN.acct = PJ_ACCOUNT.gl_acct



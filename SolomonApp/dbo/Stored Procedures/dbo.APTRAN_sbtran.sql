 create procedure  APTRAN_sbtran @parm1 varchar (6), @parm2 varchar (10)   as
select apt.*, apd.*, pac.acct
from  APTRAN apt, APDOC apd, PJ_ACCOUNT pac
where
apt.perpost =  @parm1 and
apd.batnbr = @parm2 and
apt.rlsed =  1 and
apt.pc_status =  '1' and
apt.refnbr =  apd.refnbr and
apt.batnbr =  apd.batnbr and
apt.acct =  pac.gl_acct



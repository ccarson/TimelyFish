 create procedure  APTRAN_stran @parm1 varchar (6)   as
select *
from  APTRAN apt, APDOC apd, PJ_ACCOUNT pac
where     apt.perpost =  @parm1 and
apt.rlsed =  1 and
apt.pc_status =  '1' and
apt.refnbr =  apd.refnbr and
apt.batnbr =  apd.batnbr and
apt.acct =  pac.gl_acct



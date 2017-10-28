 create procedure  APTRAN_uRequeue  @parm1 varchar (6)  as
update APTRAN
set pc_status = '1'
where
APTRAN.perpost =  @parm1  and
APTRAN.pc_status =  '9'



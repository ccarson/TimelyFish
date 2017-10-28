 create procedure  INTRAN_uRequeue  @parm1 varchar (6)  as
update INTRAN
set pc_status = '1'
where
INTRAN.perpost =  @parm1  and
INTRAN.pc_status =  '9'



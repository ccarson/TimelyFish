 create procedure  PRTRAN_uRequeue  @parm1 varchar (6)  as
update PRTRAN
set pc_status = '1'
where
PRTRAN.perpost =  @parm1  and
PRTRAN.pc_status =  '9'



 create procedure PJBILL_spk6 @parm1 varchar (10)  as
select distinct  e.employee, e.emp_name
from
PJEMPLOY e ,  PJBILL b
where
e.employee = b.biller  and
b.biller Like @parm1
order by e.emp_name



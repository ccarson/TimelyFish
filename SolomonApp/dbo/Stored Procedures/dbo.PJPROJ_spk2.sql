 create procedure PJPROJ_spk2 @parm1 varchar (16) , @parm2 varchar (1), @parm3 varchar(4) as

select PJPROJ.*,
	MGR1.emp_name,
	MGR2.emp_name,
	customer.name
from PJPROJ
	left outer join PJEMPLOY MGR1
		on PJPROJ.manager1 = MGR1.employee
	left outer join PJEMPLOY MGR2
		on PJPROJ.manager2 = MGR2.employee
	left outer join CUSTOMER
		on PJPROJ.customer = CUSTOMER.CustId
where PJPROJ.project like @parm1
	and PJPROJ.status_pa like @parm2
	and PJPROJ.ProjCuryId like @parm3
order by PJPROJ.project


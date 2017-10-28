 create procedure PJPROJ_scont2 @parm1 varchar (16) , @parm2 varchar (1), @parm3 varchar(10), @parm4 varchar(100), @parm5 varchar(4)  
 WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
 as
select PJPROJ.*,
	MGR1.emp_name,
	MGR2.emp_name,
	customer.name
from   PJPROJ
	left outer join PJEMPLOY MGR1
		on PJPROJ.manager1 = MGR1.employee
	left outer join PJEMPLOY MGR2
		on PJPROJ.manager2 = MGR2.employee
	left outer join  CUSTOMER
		on PJPROJ.customer = CUSTOMER.CustId
where  PJPROJ.contract = @parm1
	and PJPROJ.status_pa  like @parm2
		and PJPROJ.CpnyID like @parm3
		and PJPROJ.ProjCuryId like @parm5
	and PJPROJ.CpnyID in (select cpnyid from dbo.UserAccessCpny(@parm4))
order by   PJPROJ.project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_scont2] TO [MSDSL]
    AS [dbo];


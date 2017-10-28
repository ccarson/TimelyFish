create procedure PJPENTEM_spk3 @parm1 varchar (16), @parm2 varchar (10) as
select * 
from PJPENTEM a inner join PJPROJ p on a.project = p.project
				inner join PJEMPLOY e on a.Employee = e.employee
where a.Project like @parm1
and a.Employee  like @parm2
and p.MSPInterface = 'Y'
and e.MSPInterface = 'Y'
and ( a.Budget_amt <> 0 or a.Budget_units <> 0)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENTEM_spk3] TO [MSDSL]
    AS [dbo];


 create procedure PJSUBMIT_SANALYZE @parm1 varchar (16) , @parm2 varchar (16) as
select *
from PJSUBMIT
	left outer join PJEMPLOY
		on pjsubmit.employee = pjemploy.employee
where project = @parm1 and
	subcontract = @parm2 and
	status1 = 'O'
order by project,
	subcontract,
	submitnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBMIT_SANALYZE] TO [MSDSL]
    AS [dbo];


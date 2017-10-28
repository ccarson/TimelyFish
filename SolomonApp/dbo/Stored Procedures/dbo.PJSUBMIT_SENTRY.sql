 create procedure PJSUBMIT_SENTRY @parm1 varchar (16) , @parm2 varchar (16) , @parm3 varchar (10) as
select *
from PJSUBMIT
	left outer join PJEMPLOY
		on pjsubmit.employee = pjemploy.employee
where project = @parm1 and
	subcontract = @parm2 and
	submitnbr like @parm3
order by project,
	subcontract,
	submitnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBMIT_SENTRY] TO [MSDSL]
    AS [dbo];


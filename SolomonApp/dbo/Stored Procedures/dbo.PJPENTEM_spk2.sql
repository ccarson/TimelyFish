 create procedure PJPENTEM_spk2 @parm1 varchar (16), @parm2 varchar (32), @parm3 varchar (10)  as
select *
from PJPENTEM
	left outer join PJEMPLOY
		on PJPENTEM.employee = pjemploy.employee
where PJPENTEM.project = @parm1 and
      PJPENTEM.pjt_entity = @parm2 and
	  PJPENTEM.employee like @parm3
order by PJPENTEM.project, PJPENTEM.pjt_entity, PJPENTEM.employee, PJPENTEM.SubTask_Name



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENTEM_spk2] TO [MSDSL]
    AS [dbo];


 create procedure PJPENTEM_spk1 @parm1 varchar (16), @parm2 varchar (32)  as
select *
from PJPENTEM
	left outer join PJEMPLOY
		on PJPENTEM.employee = pjemploy.employee
where PJPENTEM.project = @parm1 and
      PJPENTEM.pjt_entity = @parm2
order by PJPENTEM.employee



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENTEM_spk1] TO [MSDSL]
    AS [dbo];


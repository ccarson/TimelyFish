 create procedure PJLABHDR_Spk74 @parm1 varchar (10), @parm2 varchar (250) , @parm3 smalldatetime , @parm4 smalldatetime   , @parm5 varchar(100)
     WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
  as
select  e.manager1, e.manager2, e.gl_subacct, e.emp_name, e.employee, h.period_num,
	h.week_num, e.emp_status, e.date_hired, e.date_terminated, h.le_type, h.le_status,
	h.docnbr, s.emp_name, m.emp_name, h.pe_date, h.le_id07, e.cpnyID
from    pjemploy e
	left outer join pjlabhdr h
		on e.employee = h.employee
	left outer join pjemploy s
		on e.manager1 = s.employee
	left outer join pjemploy m
		on e.manager2 = m.employee
where   e.cpnyid  like @parm1 and
	e.emp_status <> 'P' and
	(e.date_terminated is null or e.date_terminated = ' ' or
	e.date_terminated >= @parm3) and
	h.le_status <> 'X' and
	e.date_hired <= @parm4 and
	e.cpnyid in (select cpnyid from dbo.UserAccessCpny(@parm5))
order by        e.emp_name, e.employee, h.period_num, h.week_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABHDR_Spk74] TO [MSDSL]
    AS [dbo];


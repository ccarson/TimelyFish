
create procedure PJEMPLOY_sACTIVE_w @parm1 varchar (10)  as
select Employee from PJEMPLOY
where
emp_status   = 'A' and
EMPLOYEE = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEMPLOY_sACTIVE_w] TO [MSDSL]
    AS [dbo];


 create procedure PJCONTRL_SDLL  @parm1 varchar (2) , @parm2 varchar (30)   as
select control_data from PJCONTRL
where    control_type  = @parm1
and    control_code  = @parm2
order by control_type,
control_code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCONTRL_SDLL] TO [MSDSL]
    AS [dbo];


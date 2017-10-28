 create procedure PJCONTRL_SPVTYPE @parm1 varchar (2)   as
select   distinct control_type from pjcontrl
where    control_type      LIKE @parm1
order by control_type



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCONTRL_SPVTYPE] TO [MSDSL]
    AS [dbo];


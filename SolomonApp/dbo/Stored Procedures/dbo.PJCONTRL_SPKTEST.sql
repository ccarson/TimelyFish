 create procedure PJCONTRL_SPKTEST @parm1 varchar (2)   as
select distinct control_type from pjcontrl
where    control_type      LIKE @parm1
order by control_type



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCONTRL_SPKTEST] TO [MSDSL]
    AS [dbo];


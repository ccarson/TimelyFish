 create procedure PJCONTRL_SPK1  @parm1 varchar (2) , @parm2 varchar (30)   as
select * from PJCONTRL
where control_type = @parm1
and control_code LIKE  @parm2
order by control_type,
control_code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCONTRL_SPK1] TO [MSDSL]
    AS [dbo];


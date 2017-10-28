 create procedure PJCONTRL_SPK2  @parm1 varchar (2) , @parm2 varchar (255) , @parm3 varchar (30)   as
select * from PJCONTRL
where control_type = @parm1
and control_data like @parm2
and control_code like @parm3
order by control_type,
control_code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCONTRL_SPK2] TO [MSDSL]
    AS [dbo];


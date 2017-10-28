 create procedure PJCONTRL_SALL1  @parm1 varchar (2) , @parm2 varchar (30) , @parm3 varchar (30)   as
select * from PJCONTRL
where    control_type      LIKE @parm1
and    control_code      LIKE @parm2 + @parm3
order by control_type ,
control_code



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCONTRL_SALL1] TO [MSDSL]
    AS [dbo];


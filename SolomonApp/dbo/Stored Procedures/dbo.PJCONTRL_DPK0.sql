 create procedure PJCONTRL_DPK0  @parm1 varchar (2) , @parm2 varchar (30)   as
delete from PJCONTRL
where control_type = @parm1
and control_code =  @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCONTRL_DPK0] TO [MSDSL]
    AS [dbo];


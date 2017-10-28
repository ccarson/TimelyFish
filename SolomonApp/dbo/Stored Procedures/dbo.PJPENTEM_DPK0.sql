 create procedure PJPENTEM_DPK0  @parm1 varchar (16) as
    delete from PJPENTEM
        where Project = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENTEM_DPK0] TO [MSDSL]
    AS [dbo];


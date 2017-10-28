 create procedure PJBSREV_sProj  @parm1 varchar (16)  as
select * from PJBSREV
where    PJBSREV.Project = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBSREV_sProj] TO [MSDSL]
    AS [dbo];


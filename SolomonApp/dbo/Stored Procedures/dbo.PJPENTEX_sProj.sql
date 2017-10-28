 create procedure PJPENTEX_sProj @parm1 varchar (16)   as
Select * from PJPENTEX
where PJPENTEX.project =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENTEX_sProj] TO [MSDSL]
    AS [dbo];


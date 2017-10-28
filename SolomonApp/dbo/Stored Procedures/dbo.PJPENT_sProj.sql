 create procedure PJPENT_sProj @parm1 varchar (16)   as
Select * from PJPENT
where PJPENT.project =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENT_sProj] TO [MSDSL]
    AS [dbo];


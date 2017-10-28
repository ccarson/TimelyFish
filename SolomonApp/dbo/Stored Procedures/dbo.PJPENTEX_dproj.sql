 create procedure PJPENTEX_dproj @parm1 varchar (16)   as
delete from PJPENTEX
where PJPENTEX.project =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENTEX_dproj] TO [MSDSL]
    AS [dbo];


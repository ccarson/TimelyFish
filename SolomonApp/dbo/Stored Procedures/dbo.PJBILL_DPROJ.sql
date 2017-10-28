 create procedure PJBILL_DPROJ @parm1 varchar (16)   as
delete from PJBILL
where PJBILL.project =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBILL_DPROJ] TO [MSDSL]
    AS [dbo];


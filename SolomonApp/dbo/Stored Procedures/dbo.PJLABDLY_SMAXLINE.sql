 create procedure PJLABDLY_SMAXLINE  @parm1 varchar (10)   as
select max(linenbr) from PJLABDLY
where    docnbr     =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDLY_SMAXLINE] TO [MSDSL]
    AS [dbo];


 create procedure PJLABDLY_SPK1  @parm1 varchar (10)   as
select * from PJLABDLY
where    docnbr     =  @parm1
order by docnbr, ldl_siteid, linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDLY_SPK1] TO [MSDSL]
    AS [dbo];


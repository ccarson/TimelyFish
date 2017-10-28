 create procedure SALESTAX_sPK0 @parm1 varchar (10) , @PARM2 varchar (1)   as
select * from SALESTAX
where taxid =  @parm1 and
taxtype  =  @parm2
order by taxid, taxtype



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SALESTAX_sPK0] TO [MSDSL]
    AS [dbo];


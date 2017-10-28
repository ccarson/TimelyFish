 create procedure SALESTAX_sPK1 @parm1 varchar (1) , @PARM2 varchar (10)   as
select * from SALESTAX
where taxtype  LIKE @parm1 and
taxid LIKE @parm2
order by taxid, taxtype



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SALESTAX_sPK1] TO [MSDSL]
    AS [dbo];


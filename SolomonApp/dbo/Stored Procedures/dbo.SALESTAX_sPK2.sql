 create procedure SALESTAX_sPK2 @parm1 varchar (10)   as
select * from SALESTAX
where taxid LIKE @parm1
order by taxid, taxtype



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SALESTAX_sPK2] TO [MSDSL]
    AS [dbo];


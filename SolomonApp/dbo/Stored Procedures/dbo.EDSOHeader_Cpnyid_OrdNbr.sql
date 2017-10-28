 CREATE Proc EDSOHeader_Cpnyid_OrdNbr @parm1 Char(10), @Parm2 Char(15) As
select * From EDSOHeader where Cpnyid like @parm1 and OrdNbr like @Parm2
order by Cpnyid, OrdNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOHeader_Cpnyid_OrdNbr] TO [MSDSL]
    AS [dbo];


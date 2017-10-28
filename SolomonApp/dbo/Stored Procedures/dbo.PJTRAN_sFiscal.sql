 create procedure PJTRAN_sFiscal @parm1 varchar (6)  as
select * from PJTRAN
WHERE
fiscalno >= @Parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTRAN_sFiscal] TO [MSDSL]
    AS [dbo];


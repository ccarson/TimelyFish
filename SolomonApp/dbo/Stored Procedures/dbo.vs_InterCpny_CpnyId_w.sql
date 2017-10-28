
Create Proc vs_InterCpny_CpnyId_w @parm1 varchar ( 10), @parm2 varchar ( 10) AS
Select ToCompany, Cpnyname from vs_InterCompany, vs_Company where FromCompany = @parm1 and
CpnyID = ToCompany and Module = 'ZZ' and ToCompany = @parm2


GO
GRANT CONTROL
    ON OBJECT::[dbo].[vs_InterCpny_CpnyId_w] TO [MSDSL]
    AS [dbo];


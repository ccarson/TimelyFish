 Create Proc PRDoc_BatNbr_Acct_Sub_ChkNbr_ @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 varchar ( 10) as
Select *
from PRDoc
	left outer join Employee
		on PRDoc.EmpId = Employee.EmpId
where PRDoc.BatNbr = @parm1
	and PRDoc.Acct LIKE @parm2
	and PRDoc.Sub LIKE @parm3
	and PRDoc.ChkNbr LIKE @parm4
order by BatNbr,
	Acct,
	Sub,
	PRDoc.ChkNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRDoc_BatNbr_Acct_Sub_ChkNbr_] TO [MSDSL]
    AS [dbo];


 Create Proc PRTran_BatNbr_LineNbr_PRDocEmp @parm1 varchar ( 10), @parm2beg smallint, @parm2end smallint as
Select *
from PRTran
	left outer join PRDoc
		on PRTran.ChkAcct = PRDoc.Acct
		and PRTran.ChkSub = PRDoc.Sub
		and PRTran.RefNbr = PRDoc.ChkNbr
		and PRTran.TranType = PRDoc.DocType
where PRTran.BatNbr = @parm1
	and PRTran.LineNbr BETWEEN @parm2beg and @parm2end
order by PRTran.BatNbr,
	PRTran.ChkAcct,
	PRTran.ChkSub,
	PRTran.RefNbr,
	PRTran.TranType,
	PRTran.LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_BatNbr_LineNbr_PRDocEmp] TO [MSDSL]
    AS [dbo];


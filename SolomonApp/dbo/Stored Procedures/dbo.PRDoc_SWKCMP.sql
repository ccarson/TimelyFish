 create procedure PRDoc_SWKCMP @parm1 smalldatetime , @parm2 smalldatetime   as
SELECT PRDoc.chkdate,
PRDoc.BatNbr,
PRDoc.EmpId,
PRDoc.PayPerEndDate,
PRDoc.Acct,
PRDoc.Sub,
PRDoc.Chknbr,
PRDoc.Doctype,
PRTran.*,
EarnType.*
FROM
PRDoc, PRTran, EarnType
Where
PRDoc.chkdate >= @parm1 AND
PRDoc.chkdate <= @parm2 AND
PRDoc.BatNbr = PRTran.BatNbr AND
PRDoc.EmpId = PRTran.EmpId AND
PRTran.User1 <> ' ' AND
PRTran.User4 = 0 AND
PRTran.EarnDedId = EarnType.Id AND
(EarnType.EtType = 'B' or EarnType.EtType = 'R')
Order By
PRDoc.PayPerEndDate,
PRDoc.EmpId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRDoc_SWKCMP] TO [MSDSL]
    AS [dbo];


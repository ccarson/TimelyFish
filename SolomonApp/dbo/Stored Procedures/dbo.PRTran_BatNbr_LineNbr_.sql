 Create Proc  PRTran_BatNbr_LineNbr_ @parm1 varchar ( 10), @parm2beg smallint, @parm2end smallint WITH RECOMPILE as
       SELECT *
         FROM PRTran LEFT OUTER JOIN Employee
                       ON PRTran.EmpId = Employee.EmpId
                     LEFT OUTER JOIN EarnType
                       ON PRTran.EarnDedId = EarnType.Id
        WHERE PRTran.BatNbr = @parm1
          AND PRTran.LineNbr BETWEEN @parm2beg AND @parm2end
        ORDER BY PRTran.BatNbr,
                 PRTran.ChkAcct,
                 PRTran.ChkSub,
                 PRTran.RefNbr,
                 PRTran.TranType,
                 PRTran.LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_BatNbr_LineNbr_] TO [MSDSL]
    AS [dbo];


 CREATE PROC CalcChk_Emp_Seq_PV @EmpId  varchar(10), @ChkSeq varchar(2) As
    Select CalcChk.* from CalcChk, CheckSeq
                    where CalcChk.ChkSeq    = CheckSeq.ChkSeq
                      and CalcChk.EmpID  like @EmpId
                      and CalcChk.ChkSeq like @ChkSeq
                 Order by CalcChk.ChkSeq



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CalcChk_Emp_Seq_PV] TO [MSDSL]
    AS [dbo];


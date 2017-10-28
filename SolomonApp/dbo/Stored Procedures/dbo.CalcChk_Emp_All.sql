 CREATE PROC CalcChk_Emp_All @EmpId varchar(10) AS
    SELECT * FROM CalcChk
            WHERE EmpID=@EmpID
            ORDER BY EmpId, ChkSeq



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CalcChk_Emp_All] TO [MSDSL]
    AS [dbo];


 CREATE PROC CalcChk_Emp_Seq
@EmpId  varchar(10),
@ChkSeq varchar(2)
AS
SELECT *
FROM CalcChk
WHERE EmpID=@EmpID AND ChkSeq=@ChkSeq



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CalcChk_Emp_Seq] TO [MSDSL]
    AS [dbo];


 CREATE PROC CalcChk_Emp_CleanUp
@EmpId varchar(10)
AS
DELETE CalcChk
WHERE EmpID=@EmpID

DELETE CalcChkDet
WHERE EmpID=@EmpID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CalcChk_Emp_CleanUp] TO [MSDSL]
    AS [dbo];


 CREATE PROC CalcChkDet_Emp_All
@EmpId varchar(10)
AS
SELECT *
FROM CalcChkDet
WHERE EmpID=@EmpID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CalcChkDet_Emp_All] TO [MSDSL]
    AS [dbo];


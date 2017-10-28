 CREATE PROC CalcChkDet_Emp_Type_NZ
@EmpId  varchar(10),
@EDType varchar(1)
AS
SELECT *
FROM CalcChkDet
WHERE EmpId=@EmpId
      AND EDType=@EDType
      AND (CurrEarnDedAmt<>0 OR CurrUnits<>0)
ORDER BY EmpId, ChkSeq, EDType, WrkLocId, EarnDedID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CalcChkDet_Emp_Type_NZ] TO [MSDSL]
    AS [dbo];


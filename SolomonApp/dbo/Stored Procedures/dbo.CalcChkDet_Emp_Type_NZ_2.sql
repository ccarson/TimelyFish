 CREATE PROC CalcChkDet_Emp_Type_NZ_2
@EmpId  varchar(10),
@EDType varchar(1)
AS
SELECT *
FROM CalcChkDet
WHERE EmpId=@EmpId
      AND EDType=@EDType
      AND (CurrEarnDedAmt<>0 OR CurrUnits<>0)
ORDER BY EmpId, EDType, WrkLocId, EarnDedID, ChkSeq



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CalcChkDet_Emp_Type_NZ_2] TO [MSDSL]
    AS [dbo];


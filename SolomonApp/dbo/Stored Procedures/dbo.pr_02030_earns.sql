 Create Proc pr_02030_earns
@EmpID     varchar (10),
@EarnDedID varchar (10),
@ChkSeq    varchar (2)
AS
SELECT CalcChkDet.*, EarnType.*
FROM CalcChkDet
     LEFT OUTER JOIN EarnType
         ON CalcChkDet.EarnDedId=EarnType.Id
WHERE CalcChkDet.EmpId = @EmpID
      AND CalcChkDet.EDType = 'E'
      AND CalcChkDet.EarnDedId LIKE @EarnDedID
      AND CalcChkDet.ChkSeq LIKE @ChkSeq
ORDER BY EmpId, ChkSeq, EDType, WrkLocId, EarnDedId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pr_02030_earns] TO [MSDSL]
    AS [dbo];


 Create Proc pr_02030_deds
@EmpID  varchar (10),
@CalYr  varchar (4),
@DedID  varchar (10),
@ChkSeq varchar (2)
AS
SELECT CalcChkDet.*, Deduction.*
FROM CalcChkDet
     LEFT OUTER JOIN Deduction
         ON CalcChkDet.EarnDedID=Deduction.DedID
WHERE CalcChkDet.EmpId = @EmpID
      AND CalcChkDet.EDType = 'D'
      AND CalcChkDet.EarnDedId LIKE @DedID
      AND Deduction.CalYr=@CalYr
      AND CalcChkDet.ChkSeq LIKE @ChkSeq
ORDER BY EmpId, CalcChkDet.ChkSeq, EDType, WrkLocId, EarnDedId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pr_02030_deds] TO [MSDSL]
    AS [dbo];


 CREATE PROC Upd_CalcChkDetLines_BatNbr
@BatNbr varchar (10),
@DD_Flag smallint
AS
UPDATE c
SET DetailLines=p.DetLines
FROM Employee e
     INNER JOIN CalcChk c
         ON c.EmpID=e.EmpID
     INNER JOIN (SELECT sum(case when @DD_Flag = 0 and Col1Type = 'D' then 0 else 1 end) as DetLines,EmpID,ChkSeq
                 FROM PRCheckTran
		 WHERE ASID = 0
                 GROUP BY EmpID, ChkSeq) p
         ON p.EmpID=c.EmpID AND p.ChkSeq=c.ChkSeq
WHERE e.CurrBatNbr=@BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Upd_CalcChkDetLines_BatNbr] TO [MSDSL]
    AS [dbo];


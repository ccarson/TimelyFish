 Create Proc CalcChk_BatNbr
@BatNbr varchar (10)
AS
SELECT c.*
FROM Employee e
     INNER JOIN CalcChk c
         ON c.EmpID=e.EmpID
WHERE e.CurrBatNbr=@BatNbr
ORDER BY c.EmpID, c.ChkSeq



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CalcChk_BatNbr] TO [MSDSL]
    AS [dbo];


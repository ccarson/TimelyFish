
/****** Object:  View dbo.cfvMonthlyRevRecap    Script Date: 5/27/2005 4:36:56 PM ******/

CREATE   VIEW dbo.cfvMonthlyRevRecap
AS

--*************************************************************
--	Purpose: MonthlyRevRecap
--	Author: Eric Lind
--	Date: 
--	Usage:  Report MonthlyRevRecap
--	
--*************************************************************


SELECT
   Acct, Sub, PerPost, RefNbr, TranDate, TranType As TranType, ProjectID,
   CASE DrCr WHEN 'D' THEN TranAmt ELSE 0 END As Debit,
   CASE DrCr WHEN 'C' THEN TranAmt ELSE 0 END As Credit,
   TranAmt, TranDesc
FROM ARTran
WHERE Acct = '42100'
   AND Sub = '40100000'
   AND TranType = 'CM'

UNION

SELECT
   Acct, Sub, PerPost, RefNbr, TranDate, JrnlType As TranType, ProjectID,
   CASE DrCr WHEN 'D' THEN TranAmt ELSE 0 END As Debit,
   CASE DrCr WHEN 'C' THEN TranAmt ELSE 0 END As Credit,
   TranAmt, NULL As TranDesc
FROM ARTran
WHERE Acct = '42100'
AND Sub = '40100000'
AND JrnlType = 'BI'




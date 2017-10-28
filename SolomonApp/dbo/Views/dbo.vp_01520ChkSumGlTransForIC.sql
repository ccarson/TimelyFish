 

CREATE VIEW vp_01520ChkSumGlTransForIC AS

SELECT g.batnbr, g.cpnyID, g.Module, p.UserAddress,
       cramt = SUM(CONVERT(dec(28,3),g.cramt)), 
       dramt = SUM(CONVERT(dec(28,3),g.dramt))
  FROM WrkPost p INNER JOIN Batch b
                    ON p.batnbr = b.batnbr
                   AND p.module = b.module
		 INNER JOIN GLTran g
                    ON b.batnbr = g.batnbr
                   AND b.module = g.module
                 INNER JOIN Ledger l
                    ON b.LedgerID = l.LedgerID
 WHERE dbo.getNonReversNonCorrBatType(b.BatNbr, g.Module, b.BatType) <> 'J' AND l.BalRequired = 1
GROUP BY g.batnbr,g.module,g.cpnyID,p.UserAddress


 

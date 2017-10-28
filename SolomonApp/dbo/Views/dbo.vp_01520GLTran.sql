 


CREATE VIEW vp_01520GLTran AS 

   SELECT UserAddress = w.UserAddress,
          CpnyId      = t.CpnyID,       
          Acct        = t.Acct,
          Sub         = t.Sub, 
          LedgerId    = t.LedgerId,
          PerPost     = b.PerPost,
          FiscYr      = MAX(SUBSTRING(b.PerPost,1,4)), 
          Period      = MAX(SUBSTRING(b.PerPost,5,2)), 
          CuryId      = MAX(t.BaseCuryID),
          DecPl       = MAX(c.DecPl),
          AcctType    = MAX(SUBSTRING(a.AcctType,2,1)),
          Amount      = CASE MAX(SUBSTRING(a.AcctType,2,1))
                           WHEN 'A' THEN SUM(ROUND(t.DRAmt - t.CRAmt, c.DecPl))
                           WHEN 'E' THEN SUM(ROUND(t.DRAmt - t.CRAmt, c.DecPl))
                           WHEN 'I' THEN SUM(ROUND(t.CRAmt - t.DRAmt, c.DecPl))
                           WHEN 'L' THEN SUM(ROUND(t.CRAmt - t.DRAmt, c.DecPl))
                        END
   FROM WrkPost w INNER JOIN Batch b   ON w.BatNbr = b.BatNbr AND
                                          w.Module = b.Module
                  INNER JOIN GLTran t  ON b.BatNbr = t.BatNbr AND
                                          b.Module = t.Module
                  INNER JOIN Account a ON t.Acct = a.Acct
                  INNER JOIN Currncy c ON t.BaseCuryId = c.CuryId
   GROUP BY w.UserAddress,
            t.CpnyId,
            t.Acct,
            t.Sub,
            t.LedgerID,
            b.PerPost

 

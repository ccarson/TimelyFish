 

--APPTABLE
--USETHISSYNTAX


CREATE VIEW vp_08400ARReleaseDocs  AS
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400ARReleaseDocs
*
*++* Narrative:  Used to calculate net affect of transaction on history and balance
*++*             tables.
*     

*   Called by: pp_08400, and vp_08400ARReleasedocsCustomer
* 
*/

/***** AR Release Doc View *****/

SELECT d.CuryId, CurPer = (RIGHT(RTRIM(s.PerNbr), 2)), 
        CurYr = (SUBSTRING(s.PerNbr, 1, 4)), d.DocDate, d.DueDate,
        w.UserAddress, d.PerPost, FiscYr = SUBSTRING(d.PerPost, 1, 4), 
        d.CpnyID, d.CustId, d.DocType, 
        OrigDocAmt = CONVERT(dec(28,3),d.OrigDocAmt), 
        CustomerAmt = CASE d.DocType
                WHEN 'CM' THEN (CONVERT(dec(28,3),d.OrigDocAmt) * -1)
                WHEN 'PA' THEN (CONVERT(dec(28,3),d.OrigDocAmt) * -1)
                WHEN 'PP' THEN (CONVERT(dec(28,3),d.OrigDocAmt) * -1)
                WHEN 'SC' THEN (CONVERT(dec(28,3),d.OrigDocAmt) * -1)
                WHEN 'RF' THEN (CONVERT(dec(28,3),d.OrigDocAmt) * -1)
                WHEN 'SB' THEN (CONVERT(dec(28,3),d.OrigDocAmt) * -1)
                WHEN 'RP' THEN 0
                WHEN 'NS' THEN 0
                WHEN 'NC' THEN CONVERT(dec(28,3),d.OrigDocAmt)
                WHEN 'CS' THEN 0
                WHEN 'DM' THEN CONVERT(dec(28,3),d.OrigDocAmt)
                WHEN 'IN' THEN CONVERT(dec(28,3),d.OrigDocAmt)
                WHEN 'FI' THEN CONVERT(dec(28,3),d.OrigDocAmt)
                ELSE CONVERT(dec(28,3),d.OrigDocAmt) END, 
        StmtBal = CONVERT(dec(28,3),d.StmtBal), d.SlsPerID, d.RefNbr
  FROM ARSetup s (nolock), 
       WrkRelease w INNER JOIN ARDoc d
                          ON d.BatNbr = w.BatNbr
 WHERE w.Module = 'AR'

UNION 

SELECT t.CuryId, CurPer = (RIGHT(RTRIM(s.PerNbr), 2)), 
        CurYr = (SUBSTRING(s.PerNbr, 1, 4)), t.TranDate, t.trandate, 
        w.UserAddress, t.PerPost, FiscYr = SUBSTRING(t.PerPost, 1, 4), 
        t.CpnyID, t.CustId, 
        CASE WHEN t.TranType IN ('PA', 'PP') 
              THEN 'DA' 
              ELSE t.TranType END,
        CASE WHEN t.TranType IN ('PA', 'PP') 
              THEN CONVERT(dec(28,3),t.CuryUnitPrice) 
              ELSE CONVERT(dec(28,3),t.CuryTranAmt) END, 
        CASE WHEN t.TranType IN ('PA', 'PP') 
              THEN CONVERT(dec(28,3),t.CuryUnitPrice) * -1 
              ELSE CONVERT(dec(28,3),t.CuryTranAmt) * -1 END, 
        0, ' ', t.RefNbr
  FROM  ARSetup s (nolock),
        WrkRelease w INNER JOIN ARTran t
                           ON t.BatNbr = w.BatNbr
 WHERE  w.Module = 'AR'  
   AND ((t.TranType IN ('PA', 'PP') AND t.CuryUnitPrice <> 0)  
          OR (t.TranType = 'SB' AND t.CuryTranAmt <> 0)) 
   AND t.DrCr = 'U'

 

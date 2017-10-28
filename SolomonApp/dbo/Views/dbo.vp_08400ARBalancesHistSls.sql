 

CREATE view vp_08400ARBalancesHistSls  as
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400ARBalancesHistSlS
*
*++* Narrative:  Finds and sums documents for both SlsPerhist table.
*                
*
*   Called by: vp_08400ARReleaseDocsHistSls
*/
SELECT w.UserAddress, d.SlsPerID, d.DocType, 
       d.perpost,  -- this field and the next two need to always be changed together
       FISCYR = (SUBSTRING(d.PerPost, 1, 4)),
       Period = RIGHT(RTRIM(d.PerPost),2),
       HistBal = CASE d.DocType                               
                    WHEN 'IN' THEN  CONVERT(dec(28,3),d.OrigDocAmt)   
                    WHEN 'DM' THEN  CONVERT(dec(28,3),d.OrigDocAmt)
                    WHEN 'CS' THEN  CONVERT(dec(28,3),d.OrigDocAmt)
                    -- CM gets credit to entered SalesPerson not Applied Documents SalesPerson
                    WHEN 'CM' THEN -CONVERT(dec(28,3),d.OrigDocAmt) 
                    ELSE 0 
                  END 
  FROM WrkRelease w INNER JOIN ARDoc d 
                           ON w.BatNbr = d.BatNbr 
                           AND w.Module = 'AR' 
                           and d.SlsPerID <> ''
UNION ALL
/* This part of the union handles the applied portion of the payment and credit memo applications 
   since the applied portion of a payment is credited to the adjusted documents company
*/
SELECT w.userAddress, d.SlsPerID, j.AdjgDoctype, 
        j.PerAppl,   -- this field and the next two need to always be changed together
        FISCYR =    (SUBSTRING(j.PerAppl, 1, 4)), 
        Period =    RIGHT(RTRIM(j.PerAppl),2), 
        Histbal =   CASE WHEN AdjgDoctype IN ('PA','PP')     
                                      --   Receipts include Discount since no separate Disc filed in Slsperhist
                           THEN CONVERT(dec(28,3),j.AdjAmt) + CONVERT(dec(28,3),j.AdjDiscAmt)
                         WHEN AdjgDoctype = 'SB'           --   SB is really a CM and hits Negative Sales
                           THEN -CONVERT(dec(28,3),j.AdjAmt)
                         ELSE 0
                    END
  FROM WrkRelease w INNER JOIN ARAdjust j 
                       ON w.batnbr = j.AdjBatNbr 
                    INNER JOIN ARDoc d  
                       ON j.AdjdRefNbr = d.RefNbr 
                      AND j.AdjdDoctype = d.DocType
                      AND j.Custid = d.Custid
 WHERE  w.Module = 'AR' 
   AND AdjdDocType  IN ('IN','DM')  -- only give receipt credit against documents where sales credit was given
   and d.SlsPerID <> ''

UNION ALL
/* The OM part of the union
*/
SELECT w.userAddress, ls.SlsPerID, Max(j.AdjgDoctype), 
        Max(j.PerAppl),   -- this field and the next two need to always be changed together
        FISCYR =    (SUBSTRING(Max(j.PerAppl), 1, 4)), 
        Period =    RIGHT(RTRIM(Max(j.PerAppl)),2), 
        Histbal =   CASE WHEN Max(j.AdjgDoctype) IN ('PA','PP')     
                                      --   Receipts include Discount since no separate Disc filed in Slsperhist
                           THEN CONVERT(dec(28,3),Max(j.AdjAmt) * Sum(sl.TotMerch * ls.S4Future03) / 100 / Max(sh.TotMerch)) + CONVERT(dec(28,3), Max(j.AdjDiscAmt) * Sum(sl.TotMerch * ls.S4Future03) / 100 / Max(sh.TotMerch))
                         WHEN Max(j.AdjgDoctype) = 'SB'           --   SB is really a CM and hits Negative Sales
                           THEN -CONVERT(dec(28,3),Max(j.AdjAmt) * Sum(sl.TotMerch * ls.S4Future03) / 100 / Max(sh.TotMerch))
                         ELSE 0
                    END
  FROM WrkRelease w INNER JOIN ARAdjust j 
                       ON w.batnbr = j.AdjBatNbr 
                    INNER JOIN ARDoc d  
                       ON j.AdjdRefNbr = d.RefNbr 
                      AND j.AdjdDoctype = d.DocType
                      AND j.Custid = d.Custid
                    INNER JOIN SOShipHeader sh ON sh.CpnyID = d.CpnyID AND sh.ARBatNbr = d.BatNbr AND sh.InvcNbr = d.RefNbr
                    INNER JOIN SOShipLine sl ON sl.CpnyID = sh.CpnyID and sl.ShipperID = sh.ShipperID
                    INNER JOIN SOShipLineSplit ls ON sl.CpnyID = ls.CpnyID And sl.ShipperID = ls.ShipperID AND sl.LineRef = ls.LineRef
                    CROSS JOIN SOSetup s
 WHERE  w.Module = 'AR' 
   AND ls.S4Future03 <> 0 AND ls.SlsPerID <> '' AND sl.TotMerch <> 0
 GROUP BY w.UserAddress, sh.ShipperID, ls.SlsPerID


 

 

CREATE view vp_08400ARBalancesHist  as
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400ARBalancesHist
*
*++* Narrative:  Finds and sums documents both the ar_balances and arhist info.
*                
*
*   Called by: vp_08400ARReleaseDocsHist
*/


/*  First part of the union deals with the document amounts. All debit docs and the balance of the credit
    docs go to the document company. The applied portion of the credit docs is handled in the later portions 
    of the union and goes to the ajdusted docs company.
*/
SELECT w.UserAddress, d.CpnyID, d.CustId, 
        RGOLAmt = 0,
        PrePay = CASE WHEN d.doctype = 'PP' THEN CONVERT(dec(28,3),d.docbal) ELSE 0 END,
        lastinvdate = CASE WHEN d.doctype = 'IN' THEN d.docdate ELSE 0 END,
	lastactdate = d.docdate,
        d.perpost,  -- this field and the next two need to always be changed together
        FISCYR = (SUBSTRING(d.PerPost, 1, 4)),d.DocType, 
        Period = RIGHT(RTRIM(d.PerPost),2),
	HistBal = CASE d.DocType                               
                    WHEN 'IN' THEN  CONVERT(dec(28,3),d.OrigDocAmt)   
                    WHEN 'DM' THEN  CONVERT(dec(28,3),d.OrigDocAmt)
                    WHEN 'FI' THEN  CONVERT(dec(28,3),d.OrigDocAmt)
                    WHEN 'NC' THEN  CONVERT(dec(28,3),d.OrigDocAmt)
                    WHEN 'SC' THEN  CONVERT(dec(28,3),d.OrigDocAmt)
                    WHEN 'CS' THEN  CONVERT(dec(28,3),d.OrigDocAmt)
                    WHEN 'RF' THEN -CONVERT(dec(28,3),d.OrigDocAmt)
                    WHEN 'CM' THEN  CONVERT(dec(28,3),d.DocBal)
                    ELSE 0 
                  END, 
        DiscBal = 0, 
	HistRcpt = CASE d.DocType        
                     WHEN 'PA' THEN  CONVERT(dec(28,3),d.DocBal)
                     WHEN 'PP' THEN  CONVERT(dec(28,3),d.DocBal)
                     WHEN 'CS' THEN  CONVERT(dec(28,3),d.OrigDocAmt)
                     WHEN 'RF' THEN -CONVERT(dec(28,3),d.OrigDocamt)
                     ELSE 0
                   END,
        Accrued = CASE d.DocType WHEN 'AD' THEN CONVERT(dec(28,3),d.OrigDocAmt) WHEN 'RA' THEN -CONVERT(dec(28,3),d.OrigDocAmt) ELSE 0 END        
  FROM  WrkRelease w INNER JOIN ARDoc d 
                           ON w.BatNbr = d.BatNbr 
                           AND w.Module = 'AR' 
UNION ALL
/* This part of the union handles the applied portion of the payment and credit memo applications 
   since the applied portion of a payment is credited to the adjusted documents company
*/
SELECT w.userAddress, d.CpnyID, j.CustID, 
        RGOLAmt = CONVERT(dec(28,3),j.curyrgolamt),
        PrePay = CASE WHEN j.Adjgdoctype = 'PP' 
                      THEN -(CONVERT(dec(28,3),j.AdjAmt)) - CONVERT(dec(28,3),j.curyrgolamt) 
                      ELSE 0 END,
        lastinvdate = 0,
	lastactdate = 0,
        j.PerAppl,   -- this field and the next two need to always be changed together
        FISCYR =    (SUBSTRING(j.PerAppl, 1, 4)),j.adjgDoctype, 
        Period =  RIGHT(RTRIM(j.PerAppl),2), 
        Histbal =   CASE WHEN adjgDoctype IN ('CM','SB') AND AdjdDocType NOT IN ('NS','RP','SC')
                           THEN CONVERT(dec(28,3),j.AdjAmt)
                         ELSE CASE WHEN adjgDoctype = 'SB' AND AdjdDocType = 'SC'   
                                     THEN CONVERT(dec(28,3),j.AdjAmt)
                                   ELSE 0
                              END
                     END,
        DiscBal =    CONVERT(dec(28,3),j.AdjDiscAmt), 
        HistRcpt =  CASE WHEN AdjgDocType IN ('PA','PP') and AdjdDocType NOT IN ('NS','RP','SC')
                             THEN CONVERT(dec(28,3),j.AdjAmt)
                         ELSE 0
                    END,
        0
  FROM WrkRelease w INNER JOIN ARAdjust j 
                       ON w.batnbr = j.AdjBatNbr 
                    INNER JOIN ARDoc d  
                       ON j.AdjdRefNbr = d.RefNbr 
                      AND j.AdjdDoctype = d.DocType
                      AND j.Custid = d.Custid
 WHERE  w.Module = 'AR' 

UNION ALL
/* If the credit was previously entered (docs applbatnbr <> batnbr) and is now being applied, 
   this part of the union backs out the amounts from the original credit company since the  
   previous part of the union will now put it in the adjusted docs company.
*/
SELECT  w.userAddress, g.CpnyID, j.CustID, 
        RGOLAmt = 0,
        PrePay = 0,
        lastinvdate = 0,
	lastactdate = 0,        
        j.PerAppl,   -- this field and the next two need to always be changed together
        FISCYR = (SUBSTRING(j.PerAppl, 1, 4)),j.adjgDoctype,
        Period =  RIGHT(RTRIM(j.PerAppl),2),
        Histbal = CASE WHEN AdjgDoctype IN ('CM') and AdjdDocType <> 'SC'
                        THEN -(CONVERT(dec(28,3),j.AdjAmt) - CONVERT(dec(28,3),j.CuryRgolAmt))
                       ELSE 0 
                  END,
        DiscBal = 0,  
        HistRcpt =  CASE WHEN AdjgDocType IN ('PA','PP') and AdjdDocType <> 'SC'
                             THEN -(CONVERT(dec(28,3),j.AdjAmt) - CONVERT(dec(28,3),j.CuryRgolAmt))
                         ELSE 0
                    END,
        0
FROM WrkRelease w INNER JOIN ARAdjust j 
                        ON w.batnbr = j.AdjBatNbr 
                  INNER JOIN ARDoc g
                        ON j.AdjgRefNbr = g.RefNbr 
                        AND j.AdjgDoctype = g.DocType
                        AND j.Custid = g.Custid
 WHERE w.Module = 'AR' and g.applbatnbr <> g.batnbr 



 

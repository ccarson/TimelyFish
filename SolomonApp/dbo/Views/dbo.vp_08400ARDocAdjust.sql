 


CREATE VIEW vp_08400ARDocAdjust AS
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400ARDocAdjust
*
*++* Narrative: Figures out how much of a document balance is remaining.  Used
*++*            determine if doc can be closed or not. 
*     
*
*
*   Called by: pp_08400
* 
*/

/***** Adjusted Document *****/

SELECT j.CustID, w.UserAddress, aRefNbr = j.AdjdRefNbr, aDocType = j.AdjdDocType, 
        CuryDiscAmt = SUM(CONVERT(dec(28,3),j.CuryAdjdDiscAmt)), 
        CuryAdjAmt = SUM(CONVERT(dec(28,3),j.CuryAdjdAmt)), 
        AdjDiscAmt = SUM(CONVERT(dec(28,3),j.AdjDiscAmt)), 
        AdjAmt = SUM(CONVERT(dec(28,3),j.AdjAmt)), 
        RGOLAmt = 0, d.PerPost, d.CpnyID, 
        PerAppl = MAX(v.PerAppl)
FROM WrkRelease w INNER LOOP JOIN ArAdjust j 
                               ON w.BatNbr = j.AdjBatNbr
                  INNER JOIN ARDoc d 
                               ON j.AdjdRefNbr = d.RefNbr 
                               AND j.AdjdDocType = d.DocType 
                               AND j.CustID = d.CustID 
                INNER JOIN  vp_08400ARDocAdjust_Sub_1 AS v
                               ON v.CustID = d.CustID AND 
                               v.AdjdDocType = d.DocType AND 
                               v.AdjdRefNbr = d.RefNbr 
 WHERE w.Module = 'AR'
 GROUP BY j.CustID, w.UserAddress, j.AdjdRefNbr, j.AdjdDocType, d.PerPost, d.CpnyID

UNION

SELECT j.CustID, w.UserAddress, j.AdjgRefNbr, j.AdjgDocType, CuryDiscAmt = 0, 
	CuryAdjAmt = SUM(CONVERT(dec(28,3),j.CuryAdjgAmt)), AdjDiscAmt = 0, 
        -- adjamt has to be recalculated at the paying curyrate since 
        -- stored amount is at the paid curyrate
        AdjAmt = (sum(CONVERT(dec(28,3),j.adjamt)-CONVERT(dec(28,3),j.curyrgolamt))), 
        RGOLAmt = sum(CONVERT(dec(28,3),j.curyrgolamt)), 
        d.PerPost, d.CpnyID,Max(j.perappl)
  FROM WrkRelease w INNER LOOP JOIN ARAdjust j 
                               ON w.BatNbr = j.AdjBatNbr
                    INNER JOIN ARDoc d 
                               ON j.AdjgRefNbr = d.RefNbr 
                               AND j.AdjgDocType = d.DocType 
                               AND j.CustID = d.CustID
 WHERE w.Module = 'AR' 
 GROUP BY j.CustID, w.UserAddress, j.AdjgRefNbr, j.AdjgDocType, d.PerPost, d.CpnyID

UNION

/***** Multi-Installment Correction *****/

SELECT d.CustID, w.UserAddress, d.RefNbr, d.DocType, 0, 
       CONVERT(dec(28,3),d.CuryOrigDocAmt), 0, 
       CONVERT(dec(28,3),d.OrigDocAmt), 0, 
       d.PerPost, d.CpnyID,d.perpost
  FROM WrkRelease w INNER LOOP JOIN ARDoc d 
                               ON w.BatNbr = d.BatNbr
                    INNER JOIN Terms t 
                               ON  d.Terms = t.TermsID
 WHERE d.DocType = 'IN' 
   AND t.TermsType = 'M' 
   AND w.Module = 'AR'

 

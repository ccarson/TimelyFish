 


CREATE VIEW vp_08400_AdjD AS
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400_AdjD
*
*++* Narrative: Figures out the current adjustments to adjusted docs in this batch
*     
*
*
*   Called by: pp_08400
* 
*/


SELECT SUM(CONVERT(DEC(28,3),AdjAmt) + CONVERT(DEC(28,3),AdjDiscAmt))  adjamt,  
       SUM(CONVERT(DEC(28,3),CuryAdjdAmt) + CONVERT(DEC(28,3),CuryAdjdDiscAmt))  CuryAdjdAmt,
       SUM(CONVERT(DEC(28,3),AdjDiscAmt)) AdjDiscAmt,
       SUM(CONVERT(DEC(28,3),CuryAdjdDiscAmt)) CuryAdjdDiscAmt,
       w.UserAddress,
       j.CustID,
       j.AdjdDocType,
       j.AdjdRefNbr
  FROM WrkRelease w INNER LOOP JOIN ARAdjust j
                       ON w.Batnbr = j.AdjBatnbr
 WHERE W.Module = 'AR' 
 GROUP BY w.UserAddress,
       j.CustID,
       j.AdjdDocType,
       j.AdjdRefNbr


 

 

CREATE VIEW vp_08400SumTradeDisc AS 
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400SumTradeDisc
*
*++* Narrative: This view will sum the trade discounts in a batch. 
*     
*
*
*   Called by: pp_08400
* 
*/

SELECT w.useraddress, t.batnbr, t.custid, t.trantype, t.refnbr, 
       curytranamt = SUM(CONVERT(DEC(28,3),t.curytranamt)), 
       tranamt = SUM(CONVERT(DEC(28,3),t.tranamt))
  FROM wrkrelease w (NOLOCK) INNER JOIN artran t
                                   ON w.batnbr = t.batnbr
 WHERE ((t.drcr = 'D' AND t.trantype IN ('DM', 'IN')) OR 
             (t.drcr = 'C' and t.trantype = 'CM')) 
   AND t.tranclass = 'D' 
   AND w.module = 'AR'
 GROUP BY w.useraddress, t.batnbr, t.custid, t.trantype, t.refnbr


 

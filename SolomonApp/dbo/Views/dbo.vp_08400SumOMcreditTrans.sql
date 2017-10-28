 

CREATE VIEW vp_08400SumOMcreditTrans AS 
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400SumOMcreditTrans
*
*++* Narrative: This view will sum the Order Management Credit Trans. 
*     
*
*
*   Called by: pp_08400, and vp_08400SumOMTaxTrans
* 
*/

SELECT w.useraddress, t.batnbr, t.custid, t.trantype, t.refnbr,
       curytxbltot = SUM(CONVERT(dec(28,3),t.curytranamt)), 
       txbltot = SUM(CONVERT(dec(28,3),t.tranamt))
  FROM wrkrelease w INNER LOOP JOIN batch b 
                          ON w.module = b.module 
                          AND w.batnbr = b.batnbr 
                    INNER LOOP JOIN artran t 
                          ON t.batnbr = w.batnbr 
                          
 WHERE w.module = 'AR' AND b.editscrnnbr = '08010' 
      AND b.jrnltype = 'OM' AND t.tranclass IN ('N', 'D', 'F')
GROUP BY w.useraddress, t.batnbr, t.custid, t.trantype, t.refnbr


 

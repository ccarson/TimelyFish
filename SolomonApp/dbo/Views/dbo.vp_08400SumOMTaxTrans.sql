 

CREATE VIEW vp_08400SumOMTaxTrans AS 
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400SumOMTaxTrans
*
*++* Narrative: This view will sum the Order Management Tax Trans. 
*     
*
*
*   Called by: pp_08400SalesTax
* 
*/

SELECT w.useraddress, t.cpnyid,
       YrMon = LTRIM(RTRIM(STR(DATEPART(YEAR,t.trandate)))) +
               RIGHT('0' + LTRIM(RTRIM(STR(DATEPART(MONTH,t.trandate)))),2),
       Taxid = t.s4future11,
       TotTaxColl = SUM(CONVERT(dec(28,3), CASE t.TranType 
		WHEN 'IN' THEN t.tranamt
		WHEN 'DM' THEN t.tranamt
		ELSE (t.tranamt * -1) END)), 
       TxblslsTot =  SUM(CONVERT(dec(28,3), CASE t.TranType 
		WHEN 'IN' THEN t.TxblAmt00
		WHEN 'DM' THEN t.TxblAmt00
		ELSE (t.TxblAmt00 * -1) END))


  FROM wrkrelease w INNER LOOP JOIN artran t 
                          ON t.batnbr = w.batnbr 
                          
 WHERE w.module = 'AR' AND t.jrnltype = 'OM' AND t.tranclass = 'T'
GROUP BY w.useraddress, t.cpnyid,  LTRIM(RTRIM(STR(DATEPART(YEAR,t.trandate)))) +
               RIGHT('0' + LTRIM(RTRIM(STR(DATEPART(MONTH,t.trandate)))),2), t.s4future11


 

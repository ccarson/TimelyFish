
CREATE VIEW vp_08220SalesTaxTran AS 
/********************************************************************************
*
*    View Name: vp_08220SalesTaxTran
*
*++* Narrative:  
*     
*
*
*   Called by: vp_08220SalesTaxTranRls & vp_08220SalesTaxARPrcTaxIncl
* 
*/

SELECT t.UserAddress, t.batnbr,  t.CuryId, t.CpnyID,
       CuryTaxAmt = CONVERT(dec(28,3),t.CuryTaxAmt00), 
       CuryTranAmt = CONVERT(dec(28,3),t.CuryTranAmt),
       CuryTxblAmt = CONVERT(dec(28,3),t.CuryTxblAmt00), 
       t.CustID, t.RefNbr, t.TranType, t.taxcat,
       TaxId = t.TaxId00,
       TaxAmt = CONVERT(dec(28,3),t.TaxAmt00),
       TranAmt = CONVERT(dec(28,3),t.TranAmt),
       TxblAmt = CONVERT(dec(28,3),t.TxblAmt00),
       t.RecordID
  FROM Wrk08220ARTran t
  WHERE t.TaxId00 <> ' ' 

UNION

SELECT t.UserAddress, t.batnbr,  t.CuryId, t.CpnyID,
       CuryTaxAmt = CONVERT(dec(28,3),t.CuryTaxAmt01), 
       CuryTranAmt = CONVERT(dec(28,3),t.CuryTranAmt),
       CuryTxblAmt = CONVERT(dec(28,3),t.CuryTxblAmt01), 
       t.CustID, t.RefNbr, t.TranType, t.taxcat,
       TaxId = t.TaxId01,
       TaxAmt = CONVERT(dec(28,3),t.TaxAmt01),
       TranAmt = CONVERT(dec(28,3),t.TranAmt),
       TxblAmt = CONVERT(dec(28,3),t.TxblAmt01),
       t.RecordID
  FROM Wrk08220ARTran t
  WHERE t.TaxId01 <> ' '

UNION

SELECT t.UserAddress, t.batnbr,  t.CuryId, t.CpnyID,
       CuryTaxAmt = CONVERT(dec(28,3),t.CuryTaxAmt02), 
       CuryTranAmt = CONVERT(dec(28,3),t.CuryTranAmt),
       CuryTxblAmt = CONVERT(dec(28,3),t.CuryTxblAmt02), 
       t.CustID, t.RefNbr, t.TranType, t.taxcat,
       TaxId = t.TaxId02,
       TaxAmt = CONVERT(dec(28,3),t.TaxAmt02),
       TranAmt = CONVERT(dec(28,3),t.TranAmt),
       TxblAmt = CONVERT(dec(28,3),t.TxblAmt02),
       t.RecordID
  FROM Wrk08220ARTran t
  WHERE t.TaxId02 <> ' ' 

UNION

SELECT t.UserAddress, t.batnbr,  t.CuryId, t.CpnyID,
       CuryTaxAmt = CONVERT(dec(28,3),t.CuryTaxAmt03), 
       CuryTranAmt = CONVERT(dec(28,3),t.CuryTranAmt),
       CuryTxblAmt = CONVERT(dec(28,3),t.CuryTxblAmt03), 
       t.CustID, t.RefNbr, t.TranType, t.taxcat,
       TaxId = t.TaxId03,
       TaxAmt = CONVERT(dec(28,3),t.TaxAmt03),
       TranAmt = CONVERT(dec(28,3),t.TranAmt),
       TxblAmt = CONVERT(dec(28,3),t.TxblAmt03),
       t.RecordID

  FROM Wrk08220ARTran t
  WHERE t.TaxId03 <> ' ' 


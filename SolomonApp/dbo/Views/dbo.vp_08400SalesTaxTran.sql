 

CREATE VIEW vp_08400SalesTaxTran AS 
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400SalesTaxTran
*
*++* Narrative:  
*     
*
*
*   Called by: vp_08400SalesTaxTranRls
* 
*/

SELECT w.UserAddress, t.batnbr,  t.CuryId, t.CpnyID,
       CuryTaxAmt = CONVERT(dec(28,3),t.CuryTaxAmt00), 
       CuryTranAmt = CONVERT(dec(28,3),t.CuryTranAmt),
       CuryTxblAmt = CONVERT(dec(28,3),t.CuryTxblAmt00), 
       t.CustID, t.RefNbr, t.TranType, t.taxcat,
       TaxId = t.TaxId00,
       TaxAmt = CONVERT(dec(28,3),t.TaxAmt00),
       TranAmt = CONVERT(dec(28,3),t.TranAmt),
       TxblAmt = CONVERT(dec(28,3),t.TxblAmt00),
       t.RecordID
  FROM WrkRelease w INNER JOIN ARTran t
                            ON w.BatNbr = t.BatNbr AND w.Module = 'AR'
  WHERE t.TaxId00 <> ' ' 

UNION

SELECT w.UserAddress, t.batnbr,  t.CuryId, t.CpnyID,
       CuryTaxAmt = CONVERT(dec(28,3),t.CuryTaxAmt01), 
       CuryTranAmt = CONVERT(dec(28,3),t.CuryTranAmt),
       CuryTxblAmt = CONVERT(dec(28,3),t.CuryTxblAmt01), 
       t.CustID, t.RefNbr, t.TranType, t.taxcat,
       TaxId = t.TaxId01,
       TaxAmt = CONVERT(dec(28,3),t.TaxAmt01),
       TranAmt = CONVERT(dec(28,3),t.TranAmt),
       TxblAmt = CONVERT(dec(28,3),t.TxblAmt01),
       t.RecordID
  FROM WrkRelease w INNER JOIN ARTran t
                          ON w.BatNbr = t.Batnbr AND w.Module = 'AR'
 WHERE t.TaxId01 <> ' '

UNION

SELECT w.UserAddress, t.batnbr,  t.CuryId, t.CpnyID,
       CuryTaxAmt = CONVERT(dec(28,3),t.CuryTaxAmt02), 
       CuryTranAmt = CONVERT(dec(28,3),t.CuryTranAmt),
       CuryTxblAmt = CONVERT(dec(28,3),t.CuryTxblAmt02), 
       t.CustID, t.RefNbr, t.TranType, t.taxcat,
       TaxId = t.TaxId02,
       TaxAmt = CONVERT(dec(28,3),t.TaxAmt02),
       TranAmt = CONVERT(dec(28,3),t.TranAmt),
       TxblAmt = CONVERT(dec(28,3),t.TxblAmt02),
       t.RecordID
  FROM WrkRelease w INNER JOIN ARTran t
                        ON w.BatNbr = t.BatNbr AND w.Module = 'AR'
 WHERE t.TaxId02 <> ' ' 

UNION

SELECT w.UserAddress, t.batnbr,  t.CuryId, t.CpnyID,
       CuryTaxAmt = CONVERT(dec(28,3),t.CuryTaxAmt03), 
       CuryTranAmt = CONVERT(dec(28,3),t.CuryTranAmt),
       CuryTxblAmt = CONVERT(dec(28,3),t.CuryTxblAmt03), 
       t.CustID, t.RefNbr, t.TranType, t.taxcat,
       TaxId = t.TaxId03,
       TaxAmt = CONVERT(dec(28,3),t.TaxAmt03),
       TranAmt = CONVERT(dec(28,3),t.TranAmt),
       TxblAmt = CONVERT(dec(28,3),t.TxblAmt03),
       t.RecordID

  FROM WrkRelease w INNER JOIN ARTran t
                        ON w.BatNbr = t.BatNbr AND w.Module = 'AR'
 WHERE t.TaxId03 <> ' ' 


 

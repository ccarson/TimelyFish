 

--APPTABLE
--USETHISSYNTAX


CREATE VIEW vp_SalesTaxARTran AS 
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_SalesTaxARTran
*
*++* Narrative:  
*     
*
*
*   Called by: vp_SalesTaxARTran, and vp_SalesTaxARLevel1
* 
*/

SELECT w.UserAddress, t.Acct, t.CpnyID, t.CuryId, t.CuryMultDiv, 
       Curyrate = CONVERT(dec(19,6),t.CuryRate), 
       CuryTaxAmt = CONVERT(dec(28,3),t.CuryTaxAmt00), 
       CuryTranAmt = CONVERT(dec(28,3),t.CuryTranAmt),
       CuryTxblAmt = CONVERT(dec(28,3),t.CuryTxblAmt00), t.DrCr, t.RefNbr, t.Sub, 
       TaxAmt = CONVERT(dec(28,3),t.TaxAmt00),
       t.TaxCalced, t.TaxCat, TaxId = t.TaxId00, 
       TranAmt = CONVERT(dec(28,3),t.TranAmt), t.TranDate, t.RecordID,
       t.TranType, TxblAmt = CONVERT(dec(28,3),t.TxblAmt00)
  FROM WrkRelease w INNER JOIN ARTran t
                          ON w.BatNbr = t.BatNbr AND w.Module = 'AR'
  WHERE t.TaxId00 <> ' ' 

UNION

SELECT w.UserAddress, t.Acct, t.CpnyID, t.CuryId, t.CuryMultDiv, 
       CuryRate = CONVERT(dec(19,6),t.CuryRate), 
       CuryTaxAmt = CONVERT(dec(28,3),t.CuryTaxAmt01), 
       CuryTranAmt = CONVERT(dec(28,3),t.CuryTranAmt),
       CuryTxblAmt = CONVERT(dec(28,3),t.CuryTxblAmt01), t.DrCr, t.RefNbr, t.Sub, 
       TaxAmt = CONVERT(dec(28,3),t.TaxAmt01),
       t.TaxCalced, t.TaxCat, TaxId = t.TaxId01, 
       TranAmt = CONVERT(dec(28,3),t.TranAmt), t.TranDate, t.RecordID,
       t.TranType, TxblAmt = CONVERT(dec(28,3),t.TxblAmt01)
  FROM WrkRelease w INNER JOIN ARTran t
                          ON w.BatNbr = t.Batnbr AND w.Module = 'AR'
 WHERE t.TaxId01 <> ' '

UNION

SELECT w.UserAddress, t.Acct, t.CpnyID, t.CuryId, t.CuryMultDiv, 
       CuryRate = CONVERT(dec(19,6),t.CuryRate), 
       CuryTaxAmt = CONVERT(dec(28,3),t.CuryTaxAmt02), 
       CuryTranAmt = CONVERT(dec(28,3),t.CuryTranAmt),
       CuryTxblAmt = CONVERT(dec(28,3),t.CuryTxblAmt02), t.DrCr, t.RefNbr, t.Sub, 
       TaxAmt = CONVERT(dec(28,3),t.TaxAmt02),
       t.TaxCalced, t.TaxCat, TaxId = t.TaxId02, 
       TranAmt = CONVERT(dec(28,3),t.TranAmt), t.TranDate, t.RecordID,
       t.TranType, TxblAmt = CONVERT(dec(28,3),t.TxblAmt02)
  FROM WrkRelease w INNER JOIN ARTran t
                        ON w.BatNbr = t.BatNbr AND w.Module = 'AR'
 WHERE t.TaxId02 <> ' ' 

UNION
SELECT w.UserAddress, t.Acct, t.CpnyId, t.CuryId, t.CuryMultDiv, 
       CuryRate = CONVERT(dec(19,6),t.CuryRate), 
       CuryTaxAmt = CONVERT(dec(28,3),t.CuryTaxAmt03), 
       CuryTranAmt = CONVERT(dec(28,3),t.CuryTranAmt),
       CuryTxblAmt = CONVERT(dec(28,3),t.CuryTxblAmt03), t.DrCr, t.RefNbr, t.Sub, 
       TaxAmt = CONVERT(dec(28,3),t.TaxAmt03),
       t.TaxCalced, t.TaxCat, TaxId = t.TaxId03, 
       TranAmt = CONVERT(dec(28,3),t.TranAmt), t.TranDate, t.RecordID,
       t.TranType, TxblAmt = CONVERT(dec(28,3),t.TxblAmt03)
  FROM WrkRelease w INNER JOIN ARTran t
                        ON w.BatNbr = t.BatNbr AND w.Module = 'AR'
 WHERE t.TaxId03 <> ' ' 


 

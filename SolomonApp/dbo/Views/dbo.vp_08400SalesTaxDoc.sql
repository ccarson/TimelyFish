 

CREATE VIEW vp_08400SalesTaxDoc AS 
/****** View to select all tax amounts for a given batch's doc records.	 ******/

SELECT w.UserAddress, d.BatNbr, d.CuryId, d.CpnyId,
       CuryTaxAmt = CONVERT(DEC(28,3),d.CuryTaxTot00), 
       CuryTxblAmt = CONVERT(DEC(28,3),d.CuryTxblTot00), 
       d.CustId, d.RefNbr, d.DocType, d.DocDate,
       TaxId = d.TaxId00, 
       TaxAmt = CONVERT(DEC(28,3),d.TaxTot00),
       TxblAmt = CONVERT(DEC(28,3),d.TxblTot00)
  FROM WrkRelease w inner loop join ARDoc d 
	on w.BatNbr = d.BatNbr AND w.Module = 'AR'
 WHERE d.TaxId00 <> ' ' 

UNION

SELECT w.UserAddress, d.BatNbr, d.CuryId, d.CpnyId,
       CuryTaxAmt = CONVERT(DEC(28,3),d.CuryTaxTot01), 
       CuryTxblAmt = CONVERT(DEC(28,3),d.CuryTxblTot01), 
       d.CustId, d.RefNbr, d.DocType, d.DocDate,
       TaxId = d.TaxId01, 
       TaxAmt = CONVERT(DEC(28,3),d.TaxTot01),
       TxblAmt = CONVERT(DEC(28,3),d.TxblTot01)
  FROM WrkRelease w inner loop join ARDoc d 
	on w.BatNbr = d.BatNbr AND w.Module = 'AR'
 WHERE d.TaxId01 <> ' ' 

UNION

SELECT w.UserAddress, d.BatNbr, d.CuryId, d.CpnyId,
       CuryTaxAmt = CONVERT(DEC(28,3),d.CuryTaxTot02), 
       CuryTxblAmt = CONVERT(DEC(28,3),d.CuryTxblTot02), 
       d.CustId, d.RefNbr, d.DocType, d.DocDate,
       TaxId = d.TaxId02, 
       TaxAmt = CONVERT(DEC(28,3),d.TaxTot02),
       TxblAmt = CONVERT(DEC(28,3),d.TxblTot02)
  FROM WrkRelease w inner loop join ARDoc d 
	on w.BatNbr = d.BatNbr AND w.Module = 'AR'
 WHERE d.TaxId02 <> ' ' 

UNION

SELECT w.UserAddress, d.BatNbr, d.CuryId, d.CpnyId,
       CuryTaxAmt = CONVERT(DEC(28,3),d.CuryTaxTot03), 
       CuryTxblAmt = CONVERT(DEC(28,3),d.CuryTxblTot03), 
       d.CustId, d.RefNbr, d.DocType, d.DocDate,
       TaxId = d.TaxId03, 
       TaxAmt = CONVERT(DEC(28,3),d.TaxTot03),
       TxblAmt = CONVERT(DEC(28,3),d.TxblTot03)
  FROM WrkRelease w inner loop join ARDoc d 
	on w.BatNbr = d.BatNbr AND w.Module = 'AR'
 WHERE d.TaxId03 <> ' ' 



 

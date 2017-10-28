 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_SalesTaxARChange as

SELECT w.UserAddress, d.RefNbr, d.DocType, TaxID = d.TaxID00, 
	CurrTaxAmtD = Max(d.CuryTaxTot00),
        TaxAmtD = Max(d.TaxTot00),
	CurrTaxAmt = Sum(t.CuryTaxAmt00),
        TaxAmt = Sum(t.TaxAmt00),
  	CurrTaxblAmtD = Max(d.CuryTxblTot00),
        TaxblAmtD = Max(d.TxblTot00), 
	TaxblAmt = Sum(t.TxblAmt00),
	CuryTaxblAmt = SUM(t.CuryTxblAmt00)
FROM ARDoc d, ARTran t, WrkRelease w
WHERE d.custid = t.custid AND d.DocType = t.TranType AND d.RefNbr = t.RefNbr AND 
	w.BatNbr = d.BatNbr
GROUP BY d.RefNbr, d.TaxID00, d.DocType, w.UserAddress 
HAVING (SUM(t.TxblAmt00) <> 0 OR SUM(t.TaxAmt00) <> 0)

UNION All

SELECT w.UserAddress, d.RefNbr, d.DocType, TaxID = d.TaxID01, 
        CurrTaxAmtD = Max(d.CuryTaxTot01),
        TaxAmtD = Max(d.TaxTot01),
	CurrTaxAmt = Sum(t.CuryTaxAmt01),
        TaxAmt = Sum(t.TaxAmt01),
  	CurrTaxblAmtD = Max(d.CuryTxblTot01),
        TaxblAmtD = Max(d.TxblTot01), 
	TaxblAmt = Sum(t.TxblAmt01),
	CuryTaxblAmt = SUM(t.CuryTxblAmt01)
FROM ARDoc d, ARTran t, WrkRelease w
WHERE d.custid = t.custid AND d.DocType = t.TranType AND d.RefNbr = t.RefNbr AND 
	w.BatNbr = d.BatNbr
GROUP BY d.RefNbr, d.TaxID01, d.DocType, w.UserAddress 
HAVING (SUM(t.TxblAmt01) <> 0 OR SUM(t.TaxAmt01) <> 0)

UNION All

SELECT w.UserAddress, d.RefNbr, d.DocType, TaxID = d.TaxID02, 
        CurrTaxAmtD = Max(d.CuryTaxTot02),
        TaxAmtD = Max(d.TaxTot02),
	CurrTaxAmt = Sum(t.CuryTaxAmt02),
        TaxAmt = Sum(t.TaxAmt02),
  	CurrTaxblAmtD = Max(d.CuryTxblTot02),
        TaxblAmtD = Max(d.TxblTot02), 
	TaxblAmt = Sum(t.TxblAmt02),
	CuryTaxblAmt = SUM(t.CuryTxblAmt02)
FROM ARDoc d, ARTran t, WrkRelease w
WHERE d.custid = t.custid AND d.DocType = t.TranType AND d.RefNbr = t.RefNbr AND 
	w.BatNbr = d.BatNbr
GROUP BY d.RefNbr, d.TaxID02, d.DocType, w.UserAddress 
HAVING (SUM(t.TxblAmt02) <> 0 OR SUM(t.TaxAmt02) <> 0)

UNION All

SELECT w.UserAddress, d.RefNbr, d.DocType, TaxID = d.TaxID03, 
	CurrTaxAmtD = Max(d.CuryTaxTot03),
        TaxAmtD = Max(d.TaxTot03),
	CurrTaxAmt = Sum(t.CuryTaxAmt03),
        TaxAmt = Sum(t.TaxAmt03),
  	CurrTaxblAmtD = Max(d.CuryTxblTot03),
        TaxblAmtD = Max(d.TxblTot03), 
	TaxblAmt = Sum(t.TxblAmt03),
	CuryTaxblAmt = SUM(t.CuryTxblAmt03)
FROM ARDoc d, ARTran t, WrkRelease w
WHERE d.custid = t.custid AND d.DocType = t.TranType AND d.RefNbr = t.RefNbr AND 
	w.BatNbr = d.BatNbr
GROUP BY d.RefNbr, d.TaxID03, d.DocType, w.UserAddress 
HAVING (SUM(t.TxblAmt03) <> 0 OR SUM(t.TaxAmt03) <> 0)


 

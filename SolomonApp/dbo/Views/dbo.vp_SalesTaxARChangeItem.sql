 

--APPTABLE
--USETHISSYNTAX


CREATE VIEW vp_SalesTaxARChangeItem AS

SELECT w.UserAddress, d.RefNbr, d.DocType, TaxID = d.TaxID00, 
	CurrTaxAmtD = d.CuryTaxTot00,
        TaxAmtD = d.TaxTot00,
	CurrTaxAmt = t.CuryTaxAmt00,
        TaxAmt = t.TaxAmt00,
  	CurrTaxblAmtD = d.CuryTxblTot00,
        TaxblAmtD = d.TxblTot00, 
	TaxblAmt = t.TxblAmt00,
	CuryTaxblAmt = t.CuryTxblAmt00,
	Recordid = t.Recordid,
        CuryId = d.curyid
FROM ARDoc d, ARTran t, WrkRelease w
WHERE d.DocType = t.TranType AND d.RefNbr = t.RefNbr AND 
	w.BatNbr = d.BatNbr AND (t.TxblAmt00 <> 0 OR t.TaxAmt00 <> 0)

UNION All

SELECT w.UserAddress, d.RefNbr, d.DocType, TaxID = d.TaxID01, 
        CurrTaxAmtD = d.CuryTaxTot01,
        TaxAmtD = d.TaxTot01,
	CurrTaxAmt = t.CuryTaxAmt01,
        TaxAmt = t.TaxAmt01,
  	CurrTaxblAmtD = d.CuryTxblTot01,
        TaxblAmtD = d.TxblTot01, 
	TaxblAmt = t.TxblAmt01,
	CuryTaxblAmt = t.CuryTxblAmt01,
	Recordid = t.Recordid,
        CuryID = d.curyid
FROM ARDoc d, ARTran t, WrkRelease w
WHERE d.DocType = t.TranType AND d.RefNbr = t.RefNbr AND 
	w.BatNbr = d.BatNbr AND (t.TxblAmt01 <> 0 OR t.TaxAmt01 <> 0)

UNION All

SELECT w.UserAddress, d.RefNbr, d.DocType, TaxID = d.TaxID02, 
        CurrTaxAmtD = d.CuryTaxTot02,
        TaxAmtD = d.TaxTot02,
	CurrTaxAmt = t.CuryTaxAmt02,
        TaxAmt = t.TaxAmt02,
  	CurrTaxblAmtD = d.CuryTxblTot02,
        TaxblAmtD = d.TxblTot02, 
	TaxblAmt = t.TxblAmt02,
	CuryTaxblAmt = t.CuryTxblAmt02,
	Recordid = t.Recordid,
        CuryID = d.CuryId
FROM ARDoc d, ARTran t, WrkRelease w
WHERE d.DocType = t.TranType AND d.RefNbr = t.RefNbr AND 
	w.BatNbr = d.BatNbr  AND (t.TxblAmt02 <> 0 OR t.TaxAmt02 <> 0)

UNION All

SELECT w.UserAddress, d.RefNbr, d.DocType, TaxID = d.TaxID03, 
	CurrTaxAmtD = d.CuryTaxTot03,
        TaxAmtD = d.TaxTot03,
	CurrTaxAmt = t.CuryTaxAmt03,
        TaxAmt = t.TaxAmt03,
  	CurrTaxblAmtD = d.CuryTxblTot03,
        TaxblAmtD = d.TxblTot03, 
	TaxblAmt = t.TxblAmt03,
	CuryTaxblAmt = t.CuryTxblAmt03,
	Recordid = t.Recordid,
        CuryID = d.CuryId
FROM ARDoc d, ARTran t, WrkRelease w
WHERE d.DocType = t.TranType AND d.RefNbr = t.RefNbr AND 
	w.BatNbr = d.BatNbr AND (t.TxblAmt03 <> 0 OR t.TaxAmt03 <> 0)


 

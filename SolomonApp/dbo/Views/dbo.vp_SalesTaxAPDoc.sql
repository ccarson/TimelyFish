 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_SalesTaxAPDoc AS 

/****** FileName: 0301vp_03400iSalesTaxAPDoc.Sql 						******/
/****** Last Modified by DCR  on 12/04/98 							******/
/****** View to select all tax amounts for a given batch's doc records.	 ******/

SELECT w.UserAddress, d.BatNbr, d.Acct, d.CuryId, d.CuryMultDiv, d.CuryRate, CuryTaxAmt = d.CuryTaxTot00, d.CuryDocBal,
	CuryTxblAmt = d.CuryTxblTot00, d.RefNbr, d.Sub, TaxAmt = d.TaxTot00,
	TaxId = d.TaxId00, d.DocBal, d.DocDate, d.RecordID,
	d.DocType, TxblAmt = d.TxblTot00
FROM  WrkRelease w inner loop join APDoc d ON w.BatNbr = d.BatNbr AND w.Module = 'AP'
WHERE d.TaxId00 <> ' ' 

UNION

SELECT w.UserAddress, d.BatNbr, d.Acct, d.CuryId, d.CuryMultDiv, d.CuryRate, CuryTaxAmt = d.CuryTaxTot01, d.CuryDocBal,
	CuryTxblAmt = d.CuryTxblTot01, d.RefNbr, d.Sub, TaxAmt = d.TaxTot01,
	TaxId = d.TaxId01, d.DocBal, d.DocDate, d.RecordID,
	d.DocType, TxblAmt = d.TxblTot01
FROM  WrkRelease w inner loop join APDoc d ON w.BatNbr = d.BatNbr AND w.Module = 'AP'
WHERE d.TaxId01 <> ' ' 

UNION

SELECT w.UserAddress, d.BatNbr, d.Acct, d.CuryId, d.CuryMultDiv, d.CuryRate, CuryTaxAmt = d.CuryTaxTot02, d.CuryDocBal,
	CuryTxblAmt = d.CuryTxblTot02, d.RefNbr, d.Sub, TaxAmt = d.TaxTot02,
	TaxId = d.TaxId02, d.DocBal, d.DocDate, d.RecordID,
	d.DocType, TxblAmt = d.TxblTot02
FROM  WrkRelease w inner loop join APDoc d ON w.BatNbr = d.BatNbr AND w.Module = 'AP'
WHERE d.TaxId02 <> ' '

UNION
SELECT w.UserAddress, d.BatNbr, d.Acct, d.CuryId, d.CuryMultDiv, d.CuryRate, CuryTaxAmt = d.CuryTaxTot03, d.CuryDocBal,
	CuryTxblAmt = d.CuryTxblTot03, d.RefNbr, d.Sub, TaxAmt = d.TaxTot03,
	TaxId = d.TaxId03, d.DocBal, d.DocDate, d.RecordID,
	d.DocType, TxblAmt = d.TxblTot03
FROM  WrkRelease w inner loop join APDoc d ON w.BatNbr = d.BatNbr AND w.Module = 'AP'
WHERE d.TaxId03 <> ' ' 



 

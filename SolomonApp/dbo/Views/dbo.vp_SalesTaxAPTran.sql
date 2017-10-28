 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_SalesTaxAPTran AS 

/****** FileName: 0301vp_03400SalesTaxAPTran.Sql 		******/
/****** View to select all tax amounts for a given batch's transaction records.	 ******/
SELECT w.UserAddress, t.BatNbr, t.Acct, t.CuryId, t.CuryMultDiv, t.CuryRate, CuryTaxAmt = t.CuryTaxAmt00, t.CuryTranAmt,
	CuryTxblAmt = t.CuryTxblAmt00, t.DrCr, t.ProjectID, t.RefNbr, t.Sub,t.TaskID, TaxAmt = t.TaxAmt00,
	t.TaxCalced, t.TaxCat, TaxId = t.TaxId00, t.TranAmt, t.TranDate, t.RecordID,  
	t.TranType, TxblAmt = t.TxblAmt00
FROM WrkRelease w INNER LOOP JOIN APTran t 
                     ON w.BatNbr = t.Batnbr AND w.Module = 'AP' 
WHERE t.TaxId00 <> ' ' 

UNION ALL

SELECT w.UserAddress, t.BatNbr, t.Acct, t.CuryId, t.CuryMultDiv, t.CuryRate, CuryTaxAmt = t.CuryTaxAmt01, t.CuryTranAmt,
	CuryTxblAmt = t.CuryTxblAmt01, t.DrCr,  t.ProjectID, t.RefNbr, t.Sub,t.TaskID, TaxAmt = t.TaxAmt01, 
	t.TaxCalced, t.TaxCat, TaxId = t.TaxId01, t.TranAmt, t.TranDate, t.RecordID,
	t.TranType, TxblAmt = t.TxblAmt01
FROM WrkRelease w INNER LOOP JOIN APTran t
                     ON w.BatNbr = t.Batnbr AND w.Module = 'AP' 
WHERE t.TaxId01 <> ' ' 

UNION ALL

SELECT w.UserAddress, t.BatNbr, t.Acct, t.CuryId, t.CuryMultDiv, t.CuryRate, CuryTaxAmt = t.CuryTaxAmt02, t.CuryTranAmt,
	CuryTxblAmt = t.CuryTxblAmt02, t.DrCr, t.ProjectID , t.RefNbr, t.Sub, t.TaskID, TaxAmt = t.TaxAmt02, 
	t.TaxCalced, t.TaxCat, TaxId = t.TaxId02, t.TranAmt, t.TranDate, t.RecordID,
	t.TranType, TxblAmt = t.TxblAmt02
FROM WrkRelease w INNER LOOP JOIN APTran t
                     ON w.BatNbr = t.Batnbr AND w.Module = 'AP'
WHERE t.TaxId02 <> ' ' 

UNION ALL
SELECT w.UserAddress, t.BatNbr, t.Acct, t.CuryId, t.CuryMultDiv, t.CuryRate, CuryTaxAmt = t.CuryTaxAmt03, t.CuryTranAmt,
	CuryTxblAmt = t.CuryTxblAmt03, t.DrCr, t.ProjectID, t.RefNbr, t.Sub, t.TaskID, TaxAmt = t.TaxAmt03,  
	t.TaxCalced, t.TaxCat, TaxId = t.TaxId03, t.TranAmt, t.TranDate, t.RecordID,
	t.TranType, TxblAmt = t.TxblAmt03
FROM WrkRelease w INNER LOOP JOIN APTran t 
                     ON w.BatNbr = t.Batnbr AND w.Module = 'AP'
WHERE t.TaxId03 <> ' ' 


 

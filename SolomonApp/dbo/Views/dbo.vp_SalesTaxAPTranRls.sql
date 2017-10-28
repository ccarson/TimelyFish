 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_SalesTaxAPTranRls AS

/****** FileName: 0302vp_03400SalesTaxAPTran.Sql 						******/
/****** Last Modified by Jason Hong on 9/11/98 							******/
/****** View to select all tax amounts for a given batch's transaction records & 	******/
/****** evaluating catagory types.  Must have vp_SalesTaxAPTran & vp_Sales Tax.	******/

SELECT d.CpnyID, t.UserAddress, t.CuryId, t.CuryMultDiv, t.CuryRate, t.CuryTaxAmt, 
	t.CuryTranAmt, t.CuryTxblAmt, t.DrCr, t.RefNbr, t.TaxAmt, t.TaxCalced, t.TaxCat,  
	t.TranAmt, t.TranDate, tRecordID = t.RecordID, t.TranType, t.TxblAmt, t.projectID, t.taskID, d.BatNbr, dCuryId = d.CuryId, 
	dCuryMultDiv = d.CuryMultDiv, d.CuryOrigDocAmt, dCuryRate = d.CuryRate, d.DocType, d.VendId, d.PerPost, d.OrigDocAmt,
	TaxAcct = CASE v.PurTaxAcct WHEN ' ' THEN t.Acct ELSE v.PurTaxAcct END, 
	TaxSub = CASE v.PurTaxSub WHEN ' ' THEN t.Sub ELSE v.PurTaxSub END, v.TaxCalcLvl, 
	v.Lvl2Exmpt, v.TaxID, v.TaxCalcType, v.TaxRate, c.DecPl, v.PrcTaxIncl, TaxDate = CASE
		WHEN APTaxPtDate = 'I' AND d.InvcDate <> ' ' THEN LTRIM(RTRIM(STR(DATEPART(YEAR, d.InvcDate)))) + RIGHT('0' + LTRIM(RTRIM(STR(DATEPART(MONTH, d.InvcDate)))),2)
		ELSE LTRIM(RTRIM(STR(DATEPART(YEAR, d.DocDate)))) + RIGHT('0' + LTRIM(RTRIM(STR(DATEPART(MONTH, d.DocDate)))),2) END ,
	v.RefType, 
        GrpTaxID = CASE WHEN v.RefType = 'G' THEN v.RecordID ELSE ' ' END
FROM vp_SalesTaxAPTran t 
	INNER JOIN APDoc d
		on t.RefNbr = d.RefNbr AND t.TranType = d.DocType and d.BatNbr = t.BatNbr
	INNER JOIN vp_SalesTax v
		on t.TaxId = v.RecordId AND t.TaxCat = v.CatId
	INNER JOIN Currncy c
		on t.CuryId = c.CuryId


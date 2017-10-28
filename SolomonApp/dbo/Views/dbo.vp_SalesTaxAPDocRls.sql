 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_SalesTaxAPDocRls AS

/****** FileName: 0302vp_vp_SalesTaxAPDocRls.Sql 						******/
/****** Last Modified by DCR on 2/26/99 							******/
/****** View to select all tax amounts for a given batch's doc records & 	******/
/****** evaluating catagory types.  Must have vp_SalesTaxAPDoc & vp_Sales Tax.	******/


SELECT DISTINCT d.CpnyID, t.UserAddress, t.CuryId, t.CuryMultDiv, t.CuryRate, t.CuryTaxAmt, 
	t.CuryDocBal, t.CuryTxblAmt, t.RefNbr, t.TaxAmt, 
	t.DocBal, t.DocDate, tRecordID = t.RecordID,  t.TxblAmt, d.BatNbr, dCuryId = d.CuryId, 
	dCuryMultDiv = d.CuryMultDiv, d.CuryOrigDocAmt, dCuryRate = d.CuryRate,  d.DocType, d.VendId, d.PerPost, d.OrigDocAmt,
	TaxAcct = CASE v.PurTaxAcct WHEN ' ' THEN t.Acct ELSE v.PurTaxAcct END, 
	TaxSub = CASE v.PurTaxSub WHEN ' ' THEN t.Sub ELSE v.PurTaxSub END, v.TaxCalcLvl, 
	v.Lvl2Exmpt, v.TaxID, v.TaxCalcType, v.TaxRate, c.DecPl, v.PrcTaxIncl, TaxDate = CASE
		WHEN APTaxPtDate = 'I' AND d.InvcDate <> ' ' THEN LTRIM(RTRIM(STR(DATEPART(YEAR, d.InvcDate)))) + RIGHT('0' + LTRIM(RTRIM(STR(DATEPART(MONTH, d.InvcDate)))),2)
		ELSE LTRIM(RTRIM(STR(DATEPART(YEAR, d.DocDate)))) + RIGHT('0' + LTRIM(RTRIM(STR(DATEPART(MONTH, d.DocDate)))),2) END,
	v.reftype,        
	GrpTaxID = CASE WHEN v.RefType = 'G' THEN v.RecordID ELSE ' ' END
FROM vp_SalesTaxAPDoc t 
	INNER JOIN APDoc d
		on t.RefNbr = d.RefNbr AND t.DocType = d.DocType AND d.BatNbr = t.BatNbr
	INNER JOIN vp_SalesTax v
		on t.TaxId = v.RecordId
	INNER JOIN Currncy c
		on t.CuryId = c.CuryId
WHERE   v.TaxCalcType = 'D'
 

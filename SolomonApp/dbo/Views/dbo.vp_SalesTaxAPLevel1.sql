 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_SalesTaxAPLevel1 AS 

/****** FileName: 0304vp_03400SalesTaxAPLevel1.Sql 							******/
/****** Last Modified by Jason Hong on 9/11/98 								******/
/****** View to select all level 1 tax amounts.  Must have vp_SalesTaxAPTran & vp_SalesTax******/

SELECT t.RecordID,
	CuryLevel1TaxAmt =  SUM(CASE 
		WHEN v.TaxCalcLvl = '1' AND v.Lvl2Exmpt = 0 AND v.RefType = 'G' THEN (t.CuryTxblAmt * v.TaxRate)/100
		WHEN v.TaxCalcLvl = '1' AND v.Lvl2Exmpt = 0 AND v.RefType = 'T' THEN t.CuryTaxAmt
		ELSE 0 END),t.UserAddress
FROM vp_SalesTaxAPTran t, vp_SalesTax v
WHERE t.TaxId = v.RecordId AND t.TaxCat = v.CatId
GROUP BY t.RecordID,t.UserAddress


 

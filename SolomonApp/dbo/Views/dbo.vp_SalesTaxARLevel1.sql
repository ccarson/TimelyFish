 

--APPTABLE
--USETHISSYNTAX


CREATE VIEW vp_SalesTaxARLevel1 AS 

SELECT t.RecordID,
        CuryLevel1TaxAmt =  SUM(CASE 
		WHEN v.TaxCalcLvl = '1' AND v.Lvl2Exmpt = 0 AND v.RefType = 'G' THEN (t.CuryTxblAmt * v.TaxRate)/100
		WHEN v.TaxCalcLvl = '1' AND v.Lvl2Exmpt = 0 AND v.RefType = 'T' THEN t.CuryTaxAmt
		ELSE 0 END),
        Level1TaxAmt =  SUM(CASE 
		WHEN v.TaxCalcLvl = '1' AND v.Lvl2Exmpt = 0 AND v.RefType = 'G' THEN (t.TxblAmt * v.TaxRate)/100
		WHEN v.TaxCalcLvl = '1' AND v.Lvl2Exmpt = 0 AND v.RefType = 'T' THEN t.TaxAmt
		ELSE 0 END),t.UserAddress
FROM vp_SalesTaxARTran t, vp_SalesTax v
WHERE t.TaxId = v.RecordId AND t.TaxCat = v.CatId
GROUP BY t.RecordID, t.UserAddress

 

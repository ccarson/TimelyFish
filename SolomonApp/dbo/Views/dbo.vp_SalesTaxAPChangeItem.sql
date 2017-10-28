 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_SalesTaxAPChangeItem AS

/****** FileName: 0303vp_03400SalesTaxAPChangeItem.Sql 				******/
/****** View to determine if there's been an override of tax amounts.	******/

SELECT w.UserAddress, t.RefNbr, t.TranType, t.RecordID, TaxID = t.TaxID00, 
	TaxAmt = t.TaxAmt00, CuryTaxAmt = t.CuryTaxAmt00
FROM WrkRelease w inner loop join APTran t ON
 w.Module = 'AP' AND w.BatNbr = t.BatNbr

UNION

SELECT w.UserAddress, t.RefNbr, t.TranType, t.RecordID, TaxID = t.TaxID01, 
	TaxAmt = t.TaxAmt01, CuryTaxAmt = t.CuryTaxAmt01
FROM WrkRelease w inner loop join APTran t ON
 w.Module = 'AP' AND w.BatNbr = t.BatNbr

UNION

SELECT w.UserAddress, t.RefNbr, t.TranType, t.RecordID, TaxID = t.TaxID02, 
	TaxAmt = t.TaxAmt02, CuryTaxAmt = t.CuryTaxAmt02
FROM WrkRelease w inner loop join APTran t ON
 w.Module = 'AP' AND w.BatNbr = t.BatNbr

UNION

SELECT w.UserAddress, t.RefNbr, t.TranType, t.RecordID, TaxID = t.TaxID03, 
	TaxAmt = t.TaxAmt03, CuryTaxAmt = t.CuryTaxAmt03
FROM WrkRelease w inner loop join APTran t ON
 w.Module = 'AP' AND w.BatNbr = t.BatNbr



 

 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_SalesTaxAPChangeDoc AS

/****** FileName: 0303vp_03400SalesTaxAPChangeDoc.Sql 				******/
/****** Last Modified by Jason Hong on 9/11/98 					******/
/****** View to determine if there's been an override of tax amounts.	******/

SELECT w.UserAddress, d.RefNbr, d.DocType, TaxID = d.TaxID00, 
	DocTaxTot = MAX(d.TaxTot00), 
	CuryDocTaxTot = MAX(d.CuryTaxTot00)
FROM WrkRelease w inner loop join APDoc d ON
 w.BatNbr = d.BatNbr AND w.Module = 'AP'
GROUP BY d.RefNbr, d.TaxID00, d.DocType, w.UserAddress 


UNION

SELECT w.UserAddress, d.RefNbr, d.DocType, TaxID = d.TaxID01, 
	DocTaxTot = MAX(d.TaxTot01), 
	CuryDocTaxTot = MAX(d.CuryTaxTot01)
FROM WrkRelease w inner loop join APDoc d ON
 w.BatNbr = d.BatNbr AND w.Module = 'AP'
GROUP BY d.RefNbr, d.TaxID01, d.DocType, w.UserAddress 


UNION

SELECT w.UserAddress, d.RefNbr, d.DocType, TaxID = d.TaxID02, 
	DocTaxTot = MAX(d.TaxTot02), 
	CuryDocTaxTot = MAX(d.CuryTaxTot02)
FROM WrkRelease w inner loop join APDoc d ON
 w.BatNbr = d.BatNbr AND w.Module = 'AP'
GROUP BY d.RefNbr, d.TaxID02, d.DocType, w.UserAddress 


UNION

SELECT w.UserAddress, d.RefNbr, d.DocType, TaxID = d.TaxID03, 
	DocTaxTot = MAX(d.TaxTot03), 
	CuryDocTaxTot = MAX(d.CuryTaxTot03)
FROM WrkRelease w inner loop join APDoc d ON
 w.BatNbr = d.BatNbr AND w.Module = 'AP'
GROUP BY d.RefNbr, d.TaxID03, d.DocType, w.UserAddress 


 

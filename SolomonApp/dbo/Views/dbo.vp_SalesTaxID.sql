 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_SalesTaxID AS 

SELECT RecordID = t.TaxID, RefType = 'T', t.* 
FROM SalesTax t
WHERE TaxType = 'T'

UNION ALL

SELECT RecordID = g.GroupID, RefType = 'G', t.* 
FROM SalesTax t inner loop join SlsTaxGrp g ON g.TaxID = t.TaxID and t.TaxType = 'T'


 

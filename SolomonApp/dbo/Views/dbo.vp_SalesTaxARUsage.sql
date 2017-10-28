 

--APPTABLE
--USETHISSYNTAX


CREATE VIEW vp_SalesTaxARUsage AS 

SELECT DISTINCT t.UserAddress, t.RefNbr, t.TranType, s.RefType, s.TaxID, t.RecordID
FROM vp_SalesTaxARTran t, vp_SalesTaxID s
WHERE t.TaxID = s.RecordID


 

 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vr_03650kw AS

SELECT v.*, cRI_ID = c.RI_ID, c.CpnyName
FROM vr_ShareAPVendorDetailKW v, APDoc d, RptCompany c
WHERE d.DocBal <> 0 AND v.Parent = d.RefNbr AND v.ParentType = d.DocType
	AND v.CpnyID = c.CpnyID


 

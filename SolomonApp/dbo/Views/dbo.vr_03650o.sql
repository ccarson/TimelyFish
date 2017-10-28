 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vr_03650o AS

SELECT v.*, cRI_ID = c.RI_ID, c.CpnyName
FROM vr_ShareAPVendorDetail v, APDoc d, RptCompany c
WHERE (d.DocBal <> 0 OR (v.docbal <> 0 and v.doctype = 'PP')) AND v.Parent = d.RefNbr AND v.ParentType = d.DocType
	AND v.CpnyID = c.CpnyID


 

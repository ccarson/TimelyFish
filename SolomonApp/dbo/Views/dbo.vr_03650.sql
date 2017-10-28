 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vr_03650 AS

SELECT v.*, cRI_ID = c.RI_ID, c.CpnyName
FROM vr_ShareAPVendorDetail v, RptCompany c
WHERE v.CpnyID = c.CpnyID


 

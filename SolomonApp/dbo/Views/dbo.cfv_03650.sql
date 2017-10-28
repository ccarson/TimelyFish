
/****** Object:  View dbo.vr_03650    Script Date: 5/31/2005 10:33:52 AM ******/

--APPTABLE
--USETHISSYNTAX

CREATE  VIEW cfv_03650 AS


SELECT v.*, cRI_ID = c.RI_ID, c.CpnyName
FROM vr_ShareAPVendorDetail v, RptCompany c
WHERE v.CpnyID = c.CpnyID



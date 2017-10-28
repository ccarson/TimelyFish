 

--APPTABLE
--USETHISSYNTAX

/****** Object:  View dbo.vr_ShareAPVendorDetailKW   Script Date: 03/25/98 3:34:12 PM ******/

CREATE VIEW vr_ShareAPVendorDetailKW AS
SELECT d.*, VName = SUBSTRING(CASE 
		WHEN CHARINDEX('~', v.Name) > 0 
		THEN rtrim(right(rtrim(v.name), (charindex('~', v.name)-2)))+' '+left(v.name,(charindex('~',v.name)-1))
		ELSE v.Name 
	END, 1, 30), vStatus = v.Status, v.APAcct, v.APSub, vCuryID = v.CuryID,
       v.User1 as VendorUser1, v.User2 as VendorUser2, v.User3 as VendorUser3, v.User4 as VendorUser4,
       v.User5 as VendorUser5, v.User6 as VendorUser6, v.User7 as VendorUser7, v.User8 as VendorUser8
FROM Vendor v, vr_ShareAPDetailKW d 
WHERE d.VendId = v.VendId AND d.ParentType NOT IN ("CK","HC","EP","ZC","VC", "VT") and d.s4future11 <> "VM"


 

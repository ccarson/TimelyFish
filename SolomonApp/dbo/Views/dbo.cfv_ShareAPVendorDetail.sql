
/****** Object:  View dbo.vr_ShareAPVendorDetail    Script Date: 5/31/2005 10:34:33 AM ******/


--APPTABLE
--USETHISSYNTAX


/****** Object:  View dbo.vr_ShareAPVendorDetail    Script Date: 03/25/98 3:34:12 PM ******/

CREATE  VIEW cfv_ShareAPVendorDetail AS
SELECT d.*, VName = SUBSTRING(CASE 
		WHEN CHARINDEX('~', v.Name) > 0 
		THEN rtrim(left(rtrim(v.name), (charindex('~', rtrim(v.name))-1)))+' '+right(rtrim(v.name),len(rtrim(v.name))-(charindex('~',rtrim(v.name))))
		ELSE v.Name 
	END, 1, 30), vStatus = v.Status, v.APAcct, v.APSub, vCuryID = v.CuryID,
       v.User1 as VendorUser1, v.User2 as VendorUser2, v.User3 as VendorUser3, v.User4 as VendorUser4,
       v.User5 as VendorUser5, v.User6 as VendorUser6, v.User7 as VendorUser7, v.User8 as VendorUser8, v.classid As class
FROM Vendor v, vr_ShareAPDetail d 
WHERE d.VendId = v.VendId AND d.ParentType NOT IN ("CK","HC","ZC", "VC", "VT")


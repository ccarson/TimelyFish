 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_03400ReleaseDocsVendor AS 

/****** File Name: 0309vp_03400ReleaseDocsVendor.Sql 			******/
/****** Last Modified by Jason Hong on 7/22/98 				******/
/****** Calculate amounts that weill affect the Vendor Balances.	******/
/****** Must have vp_03400ReleaseDocs					******/

SELECT UserAddress, VendId, v.CpnyID, CuryID = min(g.BaseCuryID),
	CurrentAmt = SUM(CASE WHEN (PerPost <= RTRIM(CurYr) + RTRIM(CurPer)) THEN round(VendorAmt, c.decpl) ELSE 0 END),
	FutureAmt = SUM(CASE WHEN (PerPost > RTRIM(CurYr) + RTRIM(CurPer)) THEN round(VendorAmt, c.decpl) ELSE 0 END), 
	LastChkDate = MAX(CASE WHEN DocType in ("PA" ,"ZC" ) THEN DocDate ELSE ' ' END), 
	LastVoDate = MAX(CASE DocType WHEN "VO" THEN DocDate ELSE ' ' END)
FROM vp_03400ReleaseDocs v, currncy c (nolock), glsetup g (nolock)
Where c.CuryID =  g.BaseCuryID
GROUP BY UserAddress, VendId, v.CpnyID


 

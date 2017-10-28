
/****** Object:  View dbo.cfv_PigGroup_ActiveBarnS    Script Date: 12/1/2005 8:19:05 PM ******/

/****** Object:  View dbo.cfv_PigGroup_ActiveBarnS    Script Date: 9/12/2005 3:14:20 PM ******/

/****** Object:  View dbo.cfv_PigGroup_ActiveBarnS    Script Date: 9/12/2005 12:13:07 PM ******/
CREATE VIEW cfv_PigGroup_ActiveBarnS (Barn, Capacity, County, CurrentInv, FacilityType, MktMgrName, OwnerDesc, ContactID, SiteName, SiteOwningCompany, State, SvcMgr)
AS
SELECT	bn.BarnNbr, ISNULL(bn.StdCap,0),  ad.County, CurrentInv=0, fct.Description, 
       mg.ContactName As MarketManager, ot.Description, ct.ContactID, ct.ContactName, st1.CpnyID, ad.State, sg.ContactName As SvcMgr
FROM  cftSite st1
JOIN cftBarn bn on st1.ContactID=bn.ContactID
JOIN cftContact ct ON st1.ContactID=ct.ContactID
JOIN cftFacilityType fct ON st1.FacilityTypeID=fct.FacilityTypeID
LEFT JOIN cftContactAddress ca WITH (NOLOCK) ON ct.ContactID=ca.ContactID AND ca.AddressTypeID='01'
LEFT JOIN cftAddress ad WITH (NOLOCK) ON ca.AddressID=ad.AddressID
LEFT JOIN cftOwnershipType ot WITH (NOLOCK) ON st1.OwnerShipTypeID=ot.OwnerShipTypeID
LEFT JOIN cfvCurrentMktSvcMgr mg ON st1.ContactID=mg.sitecontactid
LEFT JOIN cfvCrtSvcMgrName sg ON st1.ContactID=sg.sitecontactid
Where ct.StatusTypeID=1 AND bn.StatusTypeID=1 
AND st1.FacilityTypeID IN ('002', '003', '004', '005', '006', '007')
--Group by ct.ContactName,  fct.Description, ot.Description, ad.County, ad.State, st1.CpnyID, bn.BarnNbr, bn.StdCap, mg.ContactName, sg.ContactName





 

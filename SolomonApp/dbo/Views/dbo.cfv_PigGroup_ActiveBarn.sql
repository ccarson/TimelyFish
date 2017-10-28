
/****** Object:  View dbo.cfv_PigGroup_ActiveBarn    Script Date: 9/12/2005 10:23:59 AM ******/

/****** Object:  View dbo.cfv_PigGroup_ActiveBarn    Script Date: 9/1/2005 4:12:45 PM ******/
CREATE     VIEW cfv_PigGroup_ActiveBarn (SiteName, FacilityType, Ownership, County, State, SiteOwningCompany, GroupCompany, PhaseDesc,   Barn, GroupStatus, GroupID, GroupDesc, Gender, StartDate,
				   CurrentInv, Capacity, MktMgr, SvcMgr)
AS
SELECT	ct.ContactName,  fct.Description, ot.Description, ad.County, ad.State, st1.CpnyID, pg.CpnyID AS Company, ph.PhaseDesc, bn.BarnNbr, 
	pst.Description As Status, pg.PigGroupID As GroupID, pg.Description As GroupDesc, 
	pg.PigGenderTypeID As Gender, CONVERT(CHAR(10),st.StartDate,101)As StartDate, 
	iv.CurrentInv, dbo.GetBarnCapacity(ct.ContactID, bn.BarnNbr, pg.PigGroupID),  
--       Sum(iv.CurrentInv), bn.StdCap,  
       mg.ContactName As MarketManager,
       sg.ContactName As SvcMgr
FROM  cftSite st1
JOIN cftBarn bn on st1.ContactID=bn.ContactID
JOIN cftContact ct ON st1.ContactID=ct.ContactID
JOIN cftFacilityType fct ON st1.FacilityTypeID=fct.FacilityTypeID
LEFT JOIN cftContactAddress ca WITH (NOLOCK) ON ct.ContactID=ca.ContactID AND ca.AddressTypeID='01'
LEFT JOIN cftAddress ad WITH (NOLOCK) ON ca.AddressID=ad.AddressID
LEFT JOIN cftOwnershipType ot WITH (NOLOCK) ON st1.OwnerShipTypeID=ot.OwnerShipTypeID
LEFT JOIN cftPigGroup pg ON bn.ContactID=pg.SiteContactID AND bn.BarnNbr=pg.BarnNbr AND pg.PGStatusID NOT IN ('X', 'I', 'P','F')
LEFT JOIN cftPigProdPhase ph on pg.PigProdPhaseID=ph.PigProdPhaseID
LEFT JOIN cfvCurrentInv iv ON pg.ProjectID=iv.Project AND pg.TaskID=iv.TaskID
LEFT JOIN cfv_GroupStart st ON pg.ProjectID=st.ProjectID and pg.TaskID=st.TaskID AND st.Qty>0
LEFT JOIN cftPGStatus pst ON pg.PGStatusID=pst.PGStatusID
LEFT JOIN cfv_PigGroup_Capacity cp ON pg.PigGroupID=cp.PigGroupID
LEFT JOIN cfvCurrentMktSvcMgr mg ON pg.SiteContactID=mg.sitecontactid
LEFT JOIN cfvCrtSvcMgrName sg ON pg.SiteContactID=sg.sitecontactid
Where ct.StatusTypeID=1 AND bn.StatusTypeID=1 
AND st1.FacilityTypeID IN ('002', '003', '004', '005', '006', '007')
--Group by ct.ContactName,  fct.Description, ot.Description, ad.County, ad.State, st1.CpnyID, pg.CpnyID, ph.PhaseDesc, bn.BarnNbr, 
--pst.Description, pg.PigGroupID, pg.Description, pg.PigGenderTypeID, st.StartDate, bn.StdCap, mg.ContactName, sg.ContactName






 
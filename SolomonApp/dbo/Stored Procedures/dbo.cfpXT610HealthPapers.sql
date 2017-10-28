
--*************************************************************
--	Purpose: Joins foreign tables for site address info
--			to create a Health Paper Report
--	Author: Charity Anderson
--	Date:  4/28/2005
--	Usage: XT610 HealthPaper Report
--	Parms:
--*************************************************************
/* 
========================================================================================================
Change Log: 
Date        Author		 	   Change 
----------- ------------------ ----------------------------------------------------------------------
04/03/2017	Nick Honetschlager	Added "WHERE d.DState <> d.SState" to eliminate intrastate movements.
========================================================================================================
*/

CREATE procedure [dbo].[cfpXT610HealthPapers]
AS
SELECT    
	SUM(pm.EstimatedQty) as EstimatedQty
	, pm.CpnyID
	, pm.MovementDate
	, pm.PMSystemID
	, pm.SourceContactID
	, cs.ContactName as SourceFarm
	, pm.PigGENDerTypeID, 
	DestFarm = CASE WHEN o.SrcPMID is null 
					THEN cd.ContactName
					ELSE rtrim(oc.ContactName) + ' (' + rtrim(cd.ContactName) + ')' 
				END
	,sa.Address1 as SAdd1, sa.Address2 as SAdd2, sa.City as SCity, sa.State as SState 
	,sa.Zip as SZip, sa.County as SCounty, sPremise=ISNULL(cft_SITE_NAIS_SOURCE.NaisDisplayID,'N/A') 
	,dPremise=ISNULL(cft_SITE_NAIS_DESTINATION.NaisDisplayID,'N/A')
	,DAdd1 = CASE WHEN o.SrcPMID is null 
				THEN da.Address1
				ELSE do.Address1
			END 
	,DAdd2 = CASE WHEN o.SrcPMID is null 
				THEN da.Address2
				ELSE do.Address2
			END
	,DCity = CASE WHEN o.SrcPMID is null 
				THEN da.City
				ELSE do.City
			END
	,DState = CASE WHEN o.SrcPMID is null 
				THEN da.State
				ELSE do.State
			END
	,DZip = CASE WHEN o.SrcPMID is null 
				THEN da.Zip
				ELSE do.Zip
			END 
	,DCounty = CASE WHEN o.SrcPMID is null 
				THEN da.County
				ELSE do.County
			END
	,DPhone = CASE WHEN o.SrcPMID is null 
				THEN
					(SELECT MIN(PhoneNbr) FROM vCF100ContactPhone (NOLOCK) where ContactID=pm.DestContactID
					GROUP BY ContactID)
				ELSE
					(SELECT MIN(PhoneNbr) FROM vCF100ContactPhone (NOLOCK) where ContactID=op.DestContactID
					GROUP BY ContactID) 
				END
	,h.VetVisitDate
	,SPhone = (SELECT MIN(PhoneNbr) FROM vCF100ContactPhone sph (NOLOCK) where ContactID=pm.SourceContactID
			GROUP BY ContactID)
	,h.Age
	,pt.PigTypeDesc as PigType
	,v.ContactName as VetName
	,w.PICWeek
	,w.WeekOfDate
	,h.Tattoo
INTO #data
FROM dbo.cftPM pm
	LEFT JOIN cftContact cd ON pm.DestContactID=cd.ContactID
	LEFT JOIN cftSite s on pm.SourceContactID=s.ContactID
	LEFT JOIN cftSite d on pm.DestContactID=d.ContactID
	LEFT JOIN cftContactAddress dca ON dca.ContactID=cd.ContactID and dca.AddressTypeID=1
	LEFT JOIN cftAddress da ON dca.AddressID = da.AddressID
	LEFT JOIN cftContact cs ON pm.SourceContactID=cs.ContactID
	LEFT JOIN cftContactAddress sca ON sca.ContactID=cs.ContactID and sca.AddressTypeID=1
	LEFT JOIN cftAddress sa ON sa.AddressID=sca.AddressID
    LEFT JOIN cftHealthService h ON h.ContactID=pm.SourceContactID
	LEFT JOIN cftContact v ON v.ContactID=h.VetContactID     
    LEFT JOIN dbo.cftPigType pt ON pm.PigTypeID = pt.PigTypeID
	LEFT JOIN dbo.cftPigOffload o on pm.PMID=o.SrcPMID
	LEFT JOIN cftPM op on o.DestPMID=op.PMID
	LEFT JOIN cftContact oc ON op.DestContactID=oc.ContactID
	LEFT JOIN cftSite ds ON ds.ContactID=op.DestContactID
	LEFT JOIN cftWeekDefinition w on pm.MovementDate between w.WeekOfDate and w.WeekEndDate
	LEFT JOIN cftContactAddress doa ON doa.ContactID=oc.ContactID and doa.AddressTypeID=1
	LEFT JOIN cftAddress do ON doa.AddressID = do.AddressID
	LEFT JOIN CFApp_PigManagement.dbo.cft_SITE_NAIS cft_SITE_NAIS_SOURCE 
            ON s.SiteID=cft_SITE_NAIS_SOURCE.SiteID 
            AND (cft_SITE_NAIS_SOURCE.Active = 1) 
	LEFT JOIN CFApp_PigManagement.dbo.cft_SITE_NAIS cft_SITE_NAIS_DESTINATION 
            ON d.SiteID=cft_SITE_NAIS_DESTINATION.SiteID 
            AND (cft_SITE_NAIS_DESTINATION.Active = 1)
WHERE  
	(dca.AddressTypeID=1) 
	AND (sca.AddressTypeID=1) 
	AND (pm.TattooFlag<>0 or op.TattooFlag<>0)
	AND pm.Highlight<>255
	AND LEFT(pm.TranSubTypeID,1)<>'O'
GROUP BY
	pm.CpnyID
	,pm.MovementDate
	,pm.PMSystemID
	,pm.DestContactID
	,pm.SourceContactID
	,cs.ContactName
	,pm.PigGenderTypeID
	,cd.ContactName
	,sa.Address1
	,sa.Address2
	,sa.City
	,sa.State
	,sa.Zip
	,sa.County
	,da.Address1
	,da.Address2
	,da.City
	,da.State
	,da.Zip
	,da.County
	,do.Address1
	,do.Address2
	,do.City
	,do.State
	,do.Zip
	,do.County
	,h.VetVisitDate
	,h.Age
	,pt.PigTypeDesc
	,v.ContactName
	,w.PICWeek
	,w.WeekOfDate
	,h.Tattoo
	,o.SrcPMID
	,oc.ContactName
	,pm.TranSubTypeID
	,op.DestContactID
	,cft_SITE_NAIS_SOURCE.NaisDisplayID
	,cft_SITE_NAIS_DESTINATION.NaisDisplayID
SELECT d.*, SourceServiceManager.ContactName SourceServiceManagerName, dbo.FormatPhone(cftPhone.PhoneNbr) SourceServiceManagerCellPhone
FROM #data d
	LEFT OUTER JOIN (SELECT sitecontactid, ContactName, svcmgrcontactid 
		FROM dbo.cfvCrtSvcMgrName) AS SourceServiceManager
		ON SourceServiceManager.SiteContactID = d.SourceContactID
	LEFT OUTER JOIN dbo.cftContactPhone AS cftContactPhone 
		ON SourceServiceManager.svcmgrcontactid = cftContactPhone.ContactID 
			AND cftContactPhone.PhoneTypeID = '003' -- cell
	LEFT OUTER JOIN dbo.cftPhone AS cftPhone 
		ON cftContactPhone.PhoneID = cftPhone.PhoneID
WHERE d.DState <> d.SState																																				-- NJH 4/3/17

DROP TABLE #data


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfpXT610HealthPapers] TO PUBLIC
    AS [dbo];


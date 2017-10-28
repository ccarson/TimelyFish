



















-- ===================================================================
-- Author:  S ripley
-- Create date: 2014
-- Description: Selects data for CRM project service accounts extract
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CRM_project_services_extract_old]

AS
BEGIN
SET NOCOUNT ON;


select contactid, svccontactid, rowcnt
into #agronomist_contact
from
	(select contactid, svccontactid, rowcnt
	 from
		(select s.contactid, rc.relatedcontactid as svccontactid,ROW_NUMBER() OVER(PARTITION BY s.contactid ORDER BY rc.relatedcontactid) as rowcnt
		 from [SolomonApp].[dbo].[cftRelatedContact] rc (nolock)
		 join solomonapp.dbo.cftSite s (nolock)
			on rc.summaryofdetail like '%agro%' and rc.contactid = s.contactid) xx2
	) ag
where rowcnt =1

select contactid, svccontactid, rowcnt
into #elect_contact
from
	(select contactid, svccontactid, rowcnt
	 from
		(select s.contactid, rc.relatedcontactid as svccontactid,ROW_NUMBER() OVER(PARTITION BY s.contactid ORDER BY rc.relatedcontactid) as rowcnt
		 from [SolomonApp].[dbo].[cftRelatedContact] rc (nolock)
		 join solomonapp.dbo.cftSite s (nolock)
			on rc.summaryofdetail like '%electric vendor%' and rc.contactid = s.contactid) xx2
	) el
where rowcnt =1

select contactid, svccontactid, rowcnt
into #lawn_contact
from
	(select contactid, svccontactid, rowcnt
	 from
		(select s.contactid, rc.relatedcontactid as svccontactid,ROW_NUMBER() OVER(PARTITION BY s.contactid ORDER BY rc.relatedcontactid) as rowcnt
		 from [SolomonApp].[dbo].[cftRelatedContact] rc (nolock)
		 join solomonapp.dbo.cftSite s (nolock)
			on rc.summaryofdetail like '%lawn care%' and rc.contactid = s.contactid) xx2
	) ln
where rowcnt =1

select contactid, svccontactid, rowcnt
into #lp_contact
from
	(select contactid, svccontactid, rowcnt
	 from
		(select s.contactid, rc.relatedcontactid as svccontactid,ROW_NUMBER() OVER(PARTITION BY s.contactid ORDER BY rc.relatedcontactid) as rowcnt
		 from [SolomonApp].[dbo].[cftRelatedContact] rc (nolock)
		 join solomonapp.dbo.cftSite s (nolock)
			on rc.summaryofdetail like '%lp/propane%' and rc.contactid = s.contactid) xx2
	) lp
where rowcnt =1	

select contactid, svccontactid, rowcnt
into #snow_contact
from
	(select contactid, svccontactid, rowcnt
	 from
		(select s.contactid, rc.relatedcontactid as svccontactid,ROW_NUMBER() OVER(PARTITION BY s.contactid ORDER BY rc.relatedcontactid) as rowcnt
		 from [SolomonApp].[dbo].[cftRelatedContact] rc (nolock)
		 join solomonapp.dbo.cftSite s (nolock)
			on rc.summaryofdetail like '%snow removal%' and rc.contactid = s.contactid) xx2
	) sn
where rowcnt =1	

select contactid, svccontactid, rowcnt
into #well_contact
from
	(select contactid, svccontactid, rowcnt
	 from
		(select s.contactid, rc.relatedcontactid as svccontactid,ROW_NUMBER() OVER(PARTITION BY s.contactid ORDER BY rc.relatedcontactid) as rowcnt
		 from [SolomonApp].[dbo].[cftRelatedContact] rc (nolock)
		 join solomonapp.dbo.cftSite s (nolock)
			on rc.summaryofdetail like '%well company%' and rc.contactid = s.contactid) xx2
	) wl
where rowcnt =1	

select parentcontactid, childcontactid,relationship, rowcnt
into #maint
from
	(select parentcontactid, childcontactid,relationship, rowcnt
	 from
		(select r.parentcontactid, r.childcontactid, r.effectivedate,t.relationship,ROW_NUMBER() OVER(PARTITION BY r.parentcontactid ORDER BY r.effectivedate desc,r.childcontactid ) as rowcnt
		 from [CentralData].[dbo].[cftRelationshipAssignment] r (nolock) 
		 left join [CentralData].[dbo].[cftRelationship] t (nolock)
			on t.cftrelationshipid = r.cftrelationshipid 
		 where r.cftrelationshipid = 1 and t.activeflag = 'Y' ) xx2
	) wl
where rowcnt =1	and relationship is not null




select parentcontactid, childcontactid,relationship, rowcnt
into #repair
from
	(select parentcontactid, childcontactid,relationship, rowcnt
	 from
		(select r.parentcontactid, r.childcontactid, r.effectivedate,t.relationship,ROW_NUMBER() OVER(PARTITION BY r.parentcontactid ORDER BY r.effectivedate desc,r.childcontactid ) as rowcnt
		 from [CentralData].[dbo].[cftRelationshipAssignment] r (nolock) 
		 left join [CentralData].[dbo].[cftRelationship] t (nolock)
			on t.cftrelationshipid = r.cftrelationshipid 
		 where r.cftrelationshipid = 2 and t.activeflag = 'Y' ) xx2
	) wl
where rowcnt =1	and relationship is not null


select parentcontactid, childcontactid,relationship, rowcnt
into #MR
from
	(select parentcontactid, childcontactid,relationship, rowcnt
	 from
		(select r.parentcontactid, r.childcontactid, r.effectivedate,t.relationship,ROW_NUMBER() OVER(PARTITION BY r.parentcontactid ORDER BY r.effectivedate desc,r.childcontactid ) as rowcnt
		 from [CentralData].[dbo].[cftRelationshipAssignment] r (nolock) 
		 left join [CentralData].[dbo].[cftRelationship] t (nolock)
			on t.cftrelationshipid = r.cftrelationshipid 
		 where r.cftrelationshipid = 3 and t.activeflag = 'Y' ) xx2
	) wl
where rowcnt =1	and relationship is not null

select parentcontactid, childcontactid,relationship, rowcnt
into #nut
from
	(select parentcontactid, childcontactid,relationship, rowcnt
	 from
		(select r.parentcontactid, r.childcontactid, r.effectivedate,t.relationship,ROW_NUMBER() OVER(PARTITION BY r.parentcontactid ORDER BY r.effectivedate desc,r.childcontactid ) as rowcnt
		 from [CentralData].[dbo].[cftRelationshipAssignment] r (nolock) 
		 left join [CentralData].[dbo].[cftRelationship] t (nolock)
			on t.cftrelationshipid = r.cftrelationshipid 
		 where r.cftrelationshipid = 4 and t.activeflag = 'Y' ) xx2
	) wl
where rowcnt =1	and relationship is not null

select parentcontactid, childcontactid,relationship, rowcnt
into #farm
from
	(select parentcontactid, childcontactid,relationship, rowcnt
	 from
		(select r.parentcontactid, r.childcontactid, r.effectivedate,t.relationship,ROW_NUMBER() OVER(PARTITION BY r.parentcontactid ORDER BY r.effectivedate desc,r.childcontactid ) as rowcnt
		 from [CentralData].[dbo].[cftRelationshipAssignment] r (nolock) 
		 left join [CentralData].[dbo].[cftRelationship] t (nolock)
			on t.cftrelationshipid = r.cftrelationshipid 
		 where r.cftrelationshipid = 5 and t.activeflag = 'Y' ) xx2
	) wl
where rowcnt =1	and relationship is not null
	


	
	
--/* select PS accounts, does not include any account that does not match with data in the cftsite table, and does not include the LDC farrowing and ON farrowing accounts*/
select p.project as accountnumber
--, s.contactid cf_CDB_Contactid
,replicate('0', 6 - len(s.contactid)) + cast (s.contactid as varchar) as 	cf_CDB_Contactid
, s.siteid cf_CDB_SiteId, 'Project' as type, p.lupd_datetime, p.customer as f1_billingaccount, c.contactname as name
	  ,a.address1,a.address2,a.township,a.zip,ph.phonenbr
      ,a.City, a.county, a.latitude, a.longitude, a.range, a.sectionnbr, a.state
      ,sot.Description as cf_Ownershiptypedesc
      ,ft.Description as cf_facilityDesc
      ,s.sitemgrcontactid cf_mgrID
      ,ag.svccontactid as cf_CDB_agronomistcontactid
      ,el.svccontactid as cf_CDB_electriccontactid
	  ,replicate('0', 6 - len(s.feedmillcontactid)) + cast (s.feedmillcontactid as varchar) as cf_feedmillcontactid
      ,ln.svccontactid as cf_CDB_lawncontactid
      ,lp.svccontactid as cf_CDB_LPcontactid
      ,null as cf_perferredmaintenanceresource
      ,replicate('0', 6 - len(mm.MarketSvcMgrContactID)) + cast (mm.MarketSvcMgrContactID as varchar) as cf_CDB_MarketingContactid
      ,replicate('0', 6 - len(SSM.SrSvcContactID)) + cast (SSM.SrSvcContactID as varchar) as cf_CDB_SeniorServiceMgrContactid
      ,replicate('0', 6 - len(sm.SvcContactID)) + cast (sm.SvcContactID as varchar) as cf_CDB_ServiceMgrContactid
    --  ,s.sitemgrcontactid as cf_CDB_SiteMangerContactid
      ,case when s.sitemgrcontactid = 0 then null else replicate('0', 6 - len(s.sitemgrcontactid)) + cast (s.sitemgrcontactid as varchar) end 	cf_CDB_SiteMangerContactid
      ,sn.svccontactid as cf_CDB_SnowContactid
      ,wl.svccontactid as cf_CDB_WellContactid
      ,p.status_pa
      ,replicate('0', 6 - len(tmpM.childcontactid)) + cast (tmpM.childcontactid as varchar) as 	cf_cdb_mainttechcontactid
      ,replicate('0', 6 - len(tmpR.childcontactid)) + cast (tmpR.childcontactid as varchar) as 	cf_cdb_repairtechcontactid
      ,replicate('0', 6 - len(tmpMR.childcontactid)) + cast (tmpMR.childcontactid as varchar) as 	cf_cdb_repairmainttechcontactid
      ,replicate('0', 6 - len(tmpN.childcontactid)) + cast (tmpN.childcontactid as varchar) as 	cf_cdb_nutrienttechid
      ,replicate('0', 6 - len(tmpF.childcontactid)) + cast (tmpF.childcontactid as varchar) as 	cf_cdb_farmtechid
      ,feed.solomonappfeedrepresentativecontactid as cf_CDB_feedrepcontactid
FROM solomonapp.dbo.pjproj p (nolock)
join solomonapp.dbo.cftSite s (nolock)
	on s.solomonprojectid = p.project and s.siteid not in ('8121','8122')	-- LDC and ON farrowing
join solomonapp.dbo.cftcontact c (nolock)
	on c.contactid = s.contactid
LEFT JOIN solomonapp.dbo.cftContactAddress ca on c.ContactID = ca.ContactID AND ca.AddressTypeID = 1 
LEFT JOIN solomonapp.dbo.cftAddress a on ca.AddressID = a.AddressID
LEFT JOIN solomonapp.dbo.cftOwnershipType sot on sot.OwnershipTypeID = s.OwnershipTypeID
LEFT JOIN solomonapp.dbo.cftFacilityType ft on ft.FacilityTypeID = s.FacilityTypeID
left join solomonapp.dbo.cftcontactphone cp (nolock) on cp.contactid = c.contactid and cp.phonetypeid = 1
left join solomonapp.dbo.cftphone ph (nolock) on ph.phoneid = cp.phoneid
left join solomonapp.dbo.cft_SITE_FEED_REPRESENTATIVE feed (nolock) on feed.sitecontactid = s.contactid
left join #agronomist_contact ag (nolock) on ag.contactid = s.contactid
left join #elect_contact el (nolock) on el.contactid = s.contactid
left join #lawn_contact ln (nolock) on ln.contactid = s.contactid
left join #lp_contact lp (nolock) on lp.contactid = s.contactid
left join #snow_contact sn (nolock) on sn.contactid = s.contactid
left join #well_contact wl (nolock) on wl.contactid = s.contactid

left join #maint tmpM (nolock) on tmpM.parentcontactid = s.contactid
left join #repair tmpR (nolock) on tmpR.parentcontactid = s.contactid
left join #MR tmpMR (nolock) on tmpMR.parentcontactid = s.contactid
left join #Nut tmpN (nolock) on tmpN.parentcontactid = s.contactid
left join #farm tmpF (nolock) on tmpF.parentcontactid = s.contactid


      --ServiceMgr
      LEFT JOIN
            (SELECT sm1.SiteContactID,c2.ContactName SiteName,sm2.ProdSvcMgrContactID,sm2.EffectiveDate,c.ContactID SrSvcContactID,c.ContactName SrSvcName
            FROM (
                        SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                        FROM CentralData.dbo.ProdSvcMgrAssignment 
                              GROUP BY SiteContactID) sm1
      LEFT JOIN CentralData.dbo.ProdSvcMgrAssignment sm2 ON sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
      LEFT JOIN CentralData.dbo.Contact c ON c.ContactID=sm2.ProdSvcMgrContactID
      LEFT JOIN CentralData.dbo.Contact c2 ON c2.ContactID=sm1.SiteContactID) SSM
      ON SSM.SiteContactID=s.ContactID
      
      --Production/Farm ServiceMgr
      LEFT JOIN
            (SELECT sm1.SiteContactID,c2.ContactName SiteName,sm2.SvcMgrContactID,sm2.EffectiveDate,c.ContactID SvcContactID,c.ContactName SvcMgrName
            FROM(
                  SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                  FROM CentralData.dbo.SiteSvcMgrAssignment 
                        GROUP BY SiteContactID) sm1
      LEFT JOIN CentralData.dbo.SiteSvcMgrAssignment sm2 ON sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
      LEFT JOIN CentralData.dbo.Contact c ON c.ContactID=sm2.SvcMgrContactID
      LEFT JOIN CentralData.dbo.Contact c2 ON c2.ContactID=sm1.SiteContactID) SM
      ON SM.SiteContactID=s.ContactID
      
      --MarketMgr
      LEFT JOIN
            (SELECT sm1.SiteContactID,c3.ContactName SiteName,sm3.MarketSvcMgrContactID,sm3.EffectiveDate,c.ContactID SvcContactID,c.ContactName MarketMgrName
            FROM(
                  SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                  FROM CentralData.dbo.MarketSvcMgrAssignment 
                        GROUP BY SiteContactID) sm1
      LEFT JOIN CentralData.dbo.MarketSvcMgrAssignment sm3 ON sm3.SiteContactID=sm1.SiteContactID and sm3.EffectiveDate=sm1.EffectiveDate
      LEFT JOIN CentralData.dbo.Contact c ON c.ContactID = sm3.MarketSvcMgrContactID
      LEFT JOIN CentralData.dbo.Contact c3 ON c3.ContactID = sm1.SiteContactID) MM
      ON MM.SiteContactID = s.ContactID
      
WHERE
  substring(p.project,1,2) = 'ps'
and p.LUpd_DateTime >=
              (SELECT DATEADD(hour,-1,max(endTIME)) AS LastExecution
              FROM [SCRIBEINTERNAL].[SCRIBE].[USERVIEW_EXECSBYDTS]
              WHERE DTS = 'PSProjects-Service Accounts IntegrationSP.dts'
              AND COLLABORATION = 'SL-CRM Prod')
AND s.SiteID not in ('9999','1660','8000','8010','0001')  


union
/* select CF accounts, does not include any account that does not match with data in the cftcontact table*/
select p.project as accountnumber
,replicate('0', 6 - len(c.contactid)) + cast (c.contactid as varchar) as 	cf_CDB_Contactid
, null cf_CDB_SiteId, 'Project' as type, p.lupd_datetime, p.customer as f1_billingaccount, c.contactname as name
	  ,a.address1,a.address2,a.township,a.zip,ph.phonenbr
      ,a.City, a.county, a.latitude, a.longitude, a.range, a.sectionnbr, a.state
      ,null as cf_Ownershiptypedesc
      ,null as cf_facilityDesc
      ,null cf_mgrID
      ,ag.svccontactid as cf_CDB_agronomistcontactid
      ,el.svccontactid as cf_CDB_electriccontactid
      ,null as cf_feedmillcontactid
      ,ln.svccontactid as cf_CDB_lawncontactid
      ,lp.svccontactid as cf_CDB_LPcontactid
      ,null as cf_perferredmaintenanceresource
      ,null as cf_CDB_MarketingContactid
      ,null as cf_CDB_SeniorServiceMgrContactid
      ,null as cf_CDB_ServiceMgrContactid
      ,null as cf_CDB_SiteMangerContactid
      ,sn.svccontactid as cf_CDB_SnowContactid
      ,wl.svccontactid as cf_CDB_WellContactid
      ,p.status_pa
            ,replicate('0', 6 - len(tmpM.childcontactid)) + cast (tmpM.childcontactid as varchar) as 	cf_cdb_mainttechcontactid
      ,replicate('0', 6 - len(tmpR.childcontactid)) + cast (tmpR.childcontactid as varchar) as 	cf_cdb_repairtechcontactid
      ,replicate('0', 6 - len(tmpMR.childcontactid)) + cast (tmpMR.childcontactid as varchar) as 	cf_cdb_repairmainttechcontactid
      ,replicate('0', 6 - len(tmpN.childcontactid)) + cast (tmpN.childcontactid as varchar) as 	cf_cdb_nutrienttechid
      ,replicate('0', 6 - len(tmpF.childcontactid)) + cast (tmpF.childcontactid as varchar) as 	cf_cdb_farmtechid
      ,null as cf_CDB_feedrepcontactid
FROM solomonapp.dbo.pjproj p (nolock)
join solomonapp.dbo.cftcontact c (nolock)
	on cast(c.contactid as int) = cast(substring(p.project,3,4) as int)
LEFT JOIN solomonapp.dbo.cftContactAddress ca on c.ContactID = ca.ContactID AND ca.AddressTypeID = 1 
LEFT JOIN solomonapp.dbo.cftAddress a on ca.AddressID = a.AddressID
left join solomonapp.dbo.cftcontactphone cp (nolock) on cp.contactid = c.contactid and cp.phonetypeid = 1
left join solomonapp.dbo.cftphone ph (nolock) on ph.phoneid = cp.phoneid
left join #agronomist_contact ag (nolock) on ag.contactid = c.contactid
left join #elect_contact el (nolock) on el.contactid = c.contactid
left join #lawn_contact ln (nolock) on ln.contactid = c.contactid
left join #lp_contact lp (nolock) on lp.contactid = c.contactid
left join #snow_contact sn (nolock) on sn.contactid = c.contactid
left join #well_contact wl (nolock) on wl.contactid = c.contactid


left join #maint tmpM (nolock) on tmpM.parentcontactid = c.contactid
left join #repair tmpR (nolock) on tmpR.parentcontactid = c.contactid
left join #MR tmpMR (nolock) on tmpMR.parentcontactid = c.contactid
left join #Nut tmpN (nolock) on tmpN.parentcontactid = c.contactid
left join #farm tmpF (nolock) on tmpF.parentcontactid = c.contactid

      --ServiceMgr
      LEFT JOIN
            (SELECT sm1.SiteContactID,c2.ContactName SiteName,sm2.ProdSvcMgrContactID,sm2.EffectiveDate,c.ContactID SrSvcContactID,c.ContactName SrSvcName
            FROM (
                        SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                        FROM CentralData.dbo.ProdSvcMgrAssignment 
                              GROUP BY SiteContactID) sm1
      LEFT JOIN CentralData.dbo.ProdSvcMgrAssignment sm2 ON sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
      LEFT JOIN CentralData.dbo.Contact c ON c.ContactID=sm2.ProdSvcMgrContactID
      LEFT JOIN CentralData.dbo.Contact c2 ON c2.ContactID=sm1.SiteContactID) SSM
      ON SSM.SiteContactID=c.ContactID
      
      --Production/Farm ServiceMgr
      LEFT JOIN
            (SELECT sm1.SiteContactID,c2.ContactName SiteName,sm2.SvcMgrContactID,sm2.EffectiveDate,c.ContactID SvcContactID,c.ContactName SvcMgrName
            FROM(
                  SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                  FROM CentralData.dbo.SiteSvcMgrAssignment 
                        GROUP BY SiteContactID) sm1
      LEFT JOIN CentralData.dbo.SiteSvcMgrAssignment sm2 ON sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
      LEFT JOIN CentralData.dbo.Contact c ON c.ContactID=sm2.SvcMgrContactID
      LEFT JOIN CentralData.dbo.Contact c2 ON c2.ContactID=sm1.SiteContactID) SM
      ON SM.SiteContactID=c.ContactID
      
      --MarketMgr
      LEFT JOIN
            (SELECT sm1.SiteContactID,c3.ContactName SiteName,sm3.MarketSvcMgrContactID,sm3.EffectiveDate,c.ContactID SvcContactID,c.ContactName MarketMgrName
            FROM(
                  SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                  FROM CentralData.dbo.MarketSvcMgrAssignment 
                        GROUP BY SiteContactID) sm1
      LEFT JOIN CentralData.dbo.MarketSvcMgrAssignment sm3 ON sm3.SiteContactID=sm1.SiteContactID and sm3.EffectiveDate=sm1.EffectiveDate
      LEFT JOIN CentralData.dbo.Contact c ON c.ContactID = sm3.MarketSvcMgrContactID
      LEFT JOIN CentralData.dbo.Contact c3 ON c3.ContactID = sm1.SiteContactID) MM
      ON MM.SiteContactID = c.ContactID
      
WHERE
  substring(p.project,1,2) = 'cf'
and p.LUpd_DateTime >=
              (SELECT DATEADD(hour,-1,max(endTIME)) AS LastExecution
              FROM [SCRIBEINTERNAL].[SCRIBE].[USERVIEW_EXECSBYDTS]
              WHERE DTS = 'PSProjects-Service Accounts IntegrationSP.dts'
              AND COLLABORATION = 'SL-CRM Prod')

union

select p.project as accountnumber
,replicate('0', 6 - len(s.contactid)) + cast (s.contactid as varchar) as 	cf_CDB_Contactid
, s.siteid cf_CDB_SiteId, 'Project' as type, p.lupd_datetime, p.customer as f1_billingaccount, c.contactname as name
	  ,a.address1,a.address2,a.township,a.zip,ph.phonenbr
      ,a.City, a.county, a.latitude, a.longitude, a.range, a.sectionnbr, a.state
      ,sot.Description as cf_Ownershiptypedesc
      ,ft.Description as cf_facilityDesc
      ,s.sitemgrcontactid cf_mgrID
	  ,ag.svccontactid as cf_CDB_agronomistcontactid
      ,el.svccontactid as cf_CDB_electriccontactid
	  ,replicate('0', 6 - len(s.feedmillcontactid)) + cast (s.feedmillcontactid as varchar) as cf_feedmillcontactid
      ,ln.svccontactid as cf_CDB_lawncontactid
      ,lp.svccontactid as cf_CDB_LPcontactid
      ,null as cf_perferredmaintenanceresource
      ,replicate('0', 6 - len(mm.MarketSvcMgrContactID)) + cast (mm.MarketSvcMgrContactID as varchar) as cf_CDB_MarketingContactid
      ,replicate('0', 6 - len(SSM.SrSvcContactID)) + cast (SSM.SrSvcContactID as varchar) as cf_CDB_SeniorServiceMgrContactid
      ,replicate('0', 6 - len(sm.SvcContactID)) + cast (sm.SvcContactID as varchar) as cf_CDB_ServiceMgrContactid
      ,replicate('0', 6 - len(s.sitemgrcontactid)) + cast (s.sitemgrcontactid as varchar) as 	cf_CDB_SiteMangerContactid
      ,sn.svccontactid as cf_CDB_SnowContactid
      ,wl.svccontactid as cf_CDB_WellContactid
      ,p.status_pa
       ,replicate('0', 6 - len(tmpM.childcontactid)) + cast (tmpM.childcontactid as varchar) as 	cf_cdb_mainttechcontactid
      ,replicate('0', 6 - len(tmpR.childcontactid)) + cast (tmpR.childcontactid as varchar) as 	cf_cdb_repairtechcontactid
      ,replicate('0', 6 - len(tmpMR.childcontactid)) + cast (tmpMR.childcontactid as varchar) as 	cf_cdb_repairmainttechcontactid
      ,replicate('0', 6 - len(tmpN.childcontactid)) + cast (tmpN.childcontactid as varchar) as 	cf_cdb_nutrienttechid
      ,replicate('0', 6 - len(tmpF.childcontactid)) + cast (tmpF.childcontactid as varchar) as 	cf_cdb_farmtechid      
      ,feed.solomonappfeedrepresentativecontactid as cf_CDB_feedrepcontactid
FROM solomonapp.dbo.pjproj p (nolock)
join centraldata.dbo.Site s (nolock)
	on s.pigrelatedglcode = substring(p.project,3,4) 
join solomonapp.dbo.cftcontact c (nolock)
	on c.contactid = s.contactid
LEFT JOIN solomonapp.dbo.cftContactAddress ca on c.ContactID = ca.ContactID AND ca.AddressTypeID = 1 
LEFT JOIN solomonapp.dbo.cftAddress a on ca.AddressID = a.AddressID
LEFT JOIN solomonapp.dbo.cftOwnershipType sot on sot.OwnershipTypeID = s.OwnershipID
LEFT JOIN solomonapp.dbo.cftFacilityType ft on ft.FacilityTypeID = s.FacilityTypeID
left join solomonapp.dbo.cftcontactphone cp (nolock) on cp.contactid = c.contactid and cp.phonetypeid = 1
left join solomonapp.dbo.cftphone ph (nolock) on ph.phoneid = cp.phoneid
left join solomonapp.dbo.cft_SITE_FEED_REPRESENTATIVE feed (nolock) on feed.sitecontactid = s.contactid
left join #agronomist_contact ag (nolock) on ag.contactid = s.contactid
left join #elect_contact el (nolock) on el.contactid = s.contactid
left join #lawn_contact ln (nolock) on ln.contactid = s.contactid
left join #lp_contact lp (nolock) on lp.contactid = s.contactid
left join #snow_contact sn (nolock) on sn.contactid = s.contactid
left join #well_contact wl (nolock) on wl.contactid = s.contactid


left join #maint tmpM (nolock) on tmpM.parentcontactid = s.contactid
left join #repair tmpR (nolock) on tmpR.parentcontactid = s.contactid
left join #MR tmpMR (nolock) on tmpMR.parentcontactid = s.contactid
left join #Nut tmpN (nolock) on tmpN.parentcontactid = s.contactid
left join #farm tmpF (nolock) on tmpF.parentcontactid = s.contactid

      --ServiceMgr
      LEFT JOIN
            (SELECT sm1.SiteContactID,c2.ContactName SiteName,sm2.ProdSvcMgrContactID,sm2.EffectiveDate,c.ContactID SrSvcContactID,c.ContactName SrSvcName
            FROM (
                        SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                        FROM CentralData.dbo.ProdSvcMgrAssignment 
                              GROUP BY SiteContactID) sm1
      LEFT JOIN CentralData.dbo.ProdSvcMgrAssignment sm2 ON sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
      LEFT JOIN CentralData.dbo.Contact c ON c.ContactID=sm2.ProdSvcMgrContactID
      LEFT JOIN CentralData.dbo.Contact c2 ON c2.ContactID=sm1.SiteContactID) SSM
      ON SSM.SiteContactID=s.ContactID
      
      --Production/Farm ServiceMgr
      LEFT JOIN
            (SELECT sm1.SiteContactID,c2.ContactName SiteName,sm2.SvcMgrContactID,sm2.EffectiveDate,c.ContactID SvcContactID,c.ContactName SvcMgrName
            FROM(
                  SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                  FROM CentralData.dbo.SiteSvcMgrAssignment 
                        GROUP BY SiteContactID) sm1
      LEFT JOIN CentralData.dbo.SiteSvcMgrAssignment sm2 ON sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
      LEFT JOIN CentralData.dbo.Contact c ON c.ContactID=sm2.SvcMgrContactID
      LEFT JOIN CentralData.dbo.Contact c2 ON c2.ContactID=sm1.SiteContactID) SM
      ON SM.SiteContactID=s.ContactID
      
      --MarketMgr
      LEFT JOIN
            (SELECT sm1.SiteContactID,c3.ContactName SiteName,sm3.MarketSvcMgrContactID,sm3.EffectiveDate,c.ContactID SvcContactID,c.ContactName MarketMgrName
            FROM(
                  SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                  FROM CentralData.dbo.MarketSvcMgrAssignment 
                        GROUP BY SiteContactID) sm1
      LEFT JOIN CentralData.dbo.MarketSvcMgrAssignment sm3 ON sm3.SiteContactID=sm1.SiteContactID and sm3.EffectiveDate=sm1.EffectiveDate
      LEFT JOIN CentralData.dbo.Contact c ON c.ContactID = sm3.MarketSvcMgrContactID
      LEFT JOIN CentralData.dbo.Contact c3 ON c3.ContactID = sm1.SiteContactID) MM
      ON MM.SiteContactID = s.ContactID
where left(p.project,2) in ('PS')
and p.project_desc in ('c027','c028','c029','c030','c031','c032','c033','c034','c035','c036','c037')
and p.LUpd_DateTime >=
              (SELECT DATEADD(hour,-1,max(endTIME)) AS LastExecution
              FROM [SCRIBEINTERNAL].[SCRIBE].[USERVIEW_EXECSBYDTS]
              WHERE DTS = 'PSProjects-Service Accounts IntegrationSP.dts'
              AND COLLABORATION = 'SL-CRM Prod')                              

union
-- include account 'ps8121'	-- LDC farrowing 004001
select p.project as accountnumber
,replicate('0', 6 - len(s.contactid)) + cast (s.contactid as varchar) as 	cf_CDB_Contactid
, s.siteid cf_CDB_SiteId, 'Project' as type, p.lupd_datetime, p.customer as f1_billingaccount, c.contactname as name
	  ,a.address1,a.address2,a.township,a.zip,ph.phonenbr
      ,a.City, a.county, a.latitude, a.longitude, a.range, a.sectionnbr, a.state
      ,sot.Description as cf_Ownershiptypedesc
      ,ft.Description as cf_facilityDesc
      ,s.sitemgrcontactid cf_mgrID
	  ,ag.svccontactid as cf_CDB_agronomistcontactid
      ,el.svccontactid as cf_CDB_electriccontactid
	  ,replicate('0', 6 - len(s.feedmillcontactid)) + cast (s.feedmillcontactid as varchar) as cf_feedmillcontactid
      ,ln.svccontactid as cf_CDB_lawncontactid
      ,lp.svccontactid as cf_CDB_LPcontactid
      ,null as cf_perferredmaintenanceresource
      ,replicate('0', 6 - len(mm.MarketSvcMgrContactID)) + cast (mm.MarketSvcMgrContactID as varchar) as cf_CDB_MarketingContactid
      ,replicate('0', 6 - len(SSM.SrSvcContactID)) + cast (SSM.SrSvcContactID as varchar) as cf_CDB_SeniorServiceMgrContactid
      ,replicate('0', 6 - len(sm.SvcContactID)) + cast (sm.SvcContactID as varchar) as cf_CDB_ServiceMgrContactid
      ,replicate('0', 6 - len(s.sitemgrcontactid)) + cast (s.sitemgrcontactid as varchar) as 	cf_CDB_SiteMangerContactid
      ,sn.svccontactid as cf_CDB_SnowContactid
      ,wl.svccontactid as cf_CDB_WellContactid
      ,p.status_pa
      ,replicate('0', 6 - len(tmpM.childcontactid)) + cast (tmpM.childcontactid as varchar) as 	cf_cdb_mainttechcontactid
      ,replicate('0', 6 - len(tmpR.childcontactid)) + cast (tmpR.childcontactid as varchar) as 	cf_cdb_repairtechcontactid
      ,replicate('0', 6 - len(tmpMR.childcontactid)) + cast (tmpMR.childcontactid as varchar) as 	cf_cdb_repairmainttechcontactid
      ,replicate('0', 6 - len(tmpN.childcontactid)) + cast (tmpN.childcontactid as varchar) as 	cf_cdb_nutrienttechid
      ,replicate('0', 6 - len(tmpF.childcontactid)) + cast (tmpF.childcontactid as varchar) as 	cf_cdb_farmtechid
      ,feed.solomonappfeedrepresentativecontactid as cf_CDB_feedrepcontactid
FROM solomonapp.dbo.pjproj p (nolock)
join solomonapp.dbo.cftSite s (nolock)
	on s.contactid = '004001' -- LDC farrowing  
join solomonapp.dbo.cftcontact c (nolock)
	on c.contactid = s.contactid
LEFT JOIN solomonapp.dbo.cftContactAddress ca on c.ContactID = ca.ContactID AND ca.AddressTypeID = 1 
LEFT JOIN solomonapp.dbo.cftAddress a on ca.AddressID = a.AddressID
LEFT JOIN solomonapp.dbo.cftOwnershipType sot on sot.OwnershipTypeID = s.OwnershipTypeID
LEFT JOIN solomonapp.dbo.cftFacilityType ft on ft.FacilityTypeID = s.FacilityTypeID
left join solomonapp.dbo.cftcontactphone cp (nolock) on cp.contactid = c.contactid and cp.phonetypeid = 1
left join solomonapp.dbo.cftphone ph (nolock) on ph.phoneid = cp.phoneid
left join solomonapp.dbo.cft_SITE_FEED_REPRESENTATIVE feed (nolock) on feed.sitecontactid = s.contactid
left join #agronomist_contact ag (nolock) on ag.contactid = s.contactid
left join #elect_contact el (nolock) on el.contactid = s.contactid
left join #lawn_contact ln (nolock) on ln.contactid = s.contactid
left join #lp_contact lp (nolock) on lp.contactid = s.contactid
left join #snow_contact sn (nolock) on sn.contactid = s.contactid
left join #well_contact wl (nolock) on wl.contactid = s.contactid


left join #maint tmpM (nolock) on tmpM.parentcontactid = s.contactid
left join #repair tmpR (nolock) on tmpR.parentcontactid = s.contactid
left join #MR tmpMR (nolock) on tmpMR.parentcontactid = s.contactid
left join #Nut tmpN (nolock) on tmpN.parentcontactid = s.contactid
left join #farm tmpF (nolock) on tmpF.parentcontactid = s.contactid

      --ServiceMgr
      LEFT JOIN
            (SELECT sm1.SiteContactID,c2.ContactName SiteName,sm2.ProdSvcMgrContactID,sm2.EffectiveDate,c.ContactID SrSvcContactID,c.ContactName SrSvcName
            FROM (
                        SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                        FROM CentralData.dbo.ProdSvcMgrAssignment 
                              GROUP BY SiteContactID) sm1
      LEFT JOIN CentralData.dbo.ProdSvcMgrAssignment sm2 ON sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
      LEFT JOIN CentralData.dbo.Contact c ON c.ContactID=sm2.ProdSvcMgrContactID
      LEFT JOIN CentralData.dbo.Contact c2 ON c2.ContactID=sm1.SiteContactID) SSM
      ON SSM.SiteContactID=s.ContactID
      
      --Production/Farm ServiceMgr
      LEFT JOIN
            (SELECT sm1.SiteContactID,c2.ContactName SiteName,sm2.SvcMgrContactID,sm2.EffectiveDate,c.ContactID SvcContactID,c.ContactName SvcMgrName
            FROM(
                  SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                  FROM CentralData.dbo.SiteSvcMgrAssignment 
                        GROUP BY SiteContactID) sm1
      LEFT JOIN CentralData.dbo.SiteSvcMgrAssignment sm2 ON sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
      LEFT JOIN CentralData.dbo.Contact c ON c.ContactID=sm2.SvcMgrContactID
      LEFT JOIN CentralData.dbo.Contact c2 ON c2.ContactID=sm1.SiteContactID) SM
      ON SM.SiteContactID=s.ContactID
      
      --MarketMgr
      LEFT JOIN
            (SELECT sm1.SiteContactID,c3.ContactName SiteName,sm3.MarketSvcMgrContactID,sm3.EffectiveDate,c.ContactID SvcContactID,c.ContactName MarketMgrName
            FROM(
                  SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                  FROM CentralData.dbo.MarketSvcMgrAssignment 
                        GROUP BY SiteContactID) sm1
      LEFT JOIN CentralData.dbo.MarketSvcMgrAssignment sm3 ON sm3.SiteContactID=sm1.SiteContactID and sm3.EffectiveDate=sm1.EffectiveDate
      LEFT JOIN CentralData.dbo.Contact c ON c.ContactID = sm3.MarketSvcMgrContactID
      LEFT JOIN CentralData.dbo.Contact c3 ON c3.ContactID = sm1.SiteContactID) MM
      ON MM.SiteContactID = s.ContactID
where p.project = 'ps8121'	-- LDC farrowing
and p.LUpd_DateTime >=
              (SELECT DATEADD(hour,-1,max(endTIME)) AS LastExecution
              FROM [SCRIBEINTERNAL].[SCRIBE].[USERVIEW_EXECSBYDTS]
              WHERE DTS = 'PSProjects-Service Accounts IntegrationSP.dts'
              AND COLLABORATION = 'SL-CRM Prod')

union
-- include account 'ps8122'	-- ON farrowing '004002' 
select p.project as accountnumber
,replicate('0', 6 - len(s.contactid)) + cast (s.contactid as varchar) as 	cf_CDB_Contactid
, s.siteid cf_CDB_SiteId, 'Project' as type, p.lupd_datetime, p.customer as f1_billingaccount, c.contactname as name
	  ,a.address1,a.address2,a.township,a.zip,ph.phonenbr
      ,a.City, a.county, a.latitude, a.longitude, a.range, a.sectionnbr, a.state
      ,sot.Description as cf_Ownershiptypedesc
      ,ft.Description as cf_facilityDesc
      ,s.sitemgrcontactid cf_mgrID
      ,ag.svccontactid as cf_CDB_agronomistcontactid
      ,el.svccontactid as cf_CDB_electriccontactid
	  ,replicate('0', 6 - len(s.feedmillcontactid)) + cast (s.feedmillcontactid as varchar) as cf_feedmillcontactid
      ,ln.svccontactid as cf_CDB_lawncontactid
      ,lp.svccontactid as cf_CDB_LPcontactid
      ,null as cf_perferredmaintenanceresource
      ,replicate('0', 6 - len(mm.MarketSvcMgrContactID)) + cast (mm.MarketSvcMgrContactID as varchar) as cf_CDB_MarketingContactid
      ,replicate('0', 6 - len(SSM.SrSvcContactID)) + cast (SSM.SrSvcContactID as varchar) as cf_CDB_SeniorServiceMgrContactid
      ,replicate('0', 6 - len(sm.SvcContactID)) + cast (sm.SvcContactID as varchar) as cf_CDB_ServiceMgrContactid
      ,replicate('0', 6 - len(s.sitemgrcontactid)) + cast (s.sitemgrcontactid as varchar) as 	cf_CDB_SiteMangerContactid
      ,sn.svccontactid as cf_CDB_SnowContactid
      ,wl.svccontactid as cf_CDB_WellContactid
      ,p.status_pa
      ,replicate('0', 6 - len(tmpM.childcontactid)) + cast (tmpM.childcontactid as varchar) as 	cf_cdb_mainttechcontactid
      ,replicate('0', 6 - len(tmpR.childcontactid)) + cast (tmpR.childcontactid as varchar) as 	cf_cdb_repairtechcontactid
      ,replicate('0', 6 - len(tmpMR.childcontactid)) + cast (tmpMR.childcontactid as varchar) as 	cf_cdb_repairmainttechcontactid
      ,replicate('0', 6 - len(tmpN.childcontactid)) + cast (tmpN.childcontactid as varchar) as 	cf_cdb_nutrienttechid
      ,replicate('0', 6 - len(tmpF.childcontactid)) + cast (tmpF.childcontactid as varchar) as 	cf_cdb_farmtechid
      ,feed.solomonappfeedrepresentativecontactid as cf_CDB_feedrepcontactid
FROM solomonapp.dbo.pjproj p (nolock)
join solomonapp.dbo.cftSite s (nolock)
	on s.contactid = '004002' -- ON farrowing  
join solomonapp.dbo.cftcontact c (nolock)
	on c.contactid = s.contactid
LEFT JOIN solomonapp.dbo.cftContactAddress ca on c.ContactID = ca.ContactID AND ca.AddressTypeID = 1 
LEFT JOIN solomonapp.dbo.cftAddress a on ca.AddressID = a.AddressID
LEFT JOIN solomonapp.dbo.cftOwnershipType sot on sot.OwnershipTypeID = s.OwnershipTypeID
LEFT JOIN solomonapp.dbo.cftFacilityType ft on ft.FacilityTypeID = s.FacilityTypeID
left join solomonapp.dbo.cftcontactphone cp (nolock) on cp.contactid = c.contactid and cp.phonetypeid = 1
left join solomonapp.dbo.cftphone ph (nolock) on ph.phoneid = cp.phoneid
left join solomonapp.dbo.cft_SITE_FEED_REPRESENTATIVE feed (nolock) on feed.sitecontactid = s.contactid
left join #agronomist_contact ag (nolock) on ag.contactid = s.contactid
left join #elect_contact el (nolock) on el.contactid = s.contactid
left join #lawn_contact ln (nolock) on ln.contactid = s.contactid
left join #lp_contact lp (nolock) on lp.contactid = s.contactid
left join #snow_contact sn (nolock) on sn.contactid = s.contactid
left join #well_contact wl (nolock) on wl.contactid = s.contactid


left join #maint tmpM (nolock) on tmpM.parentcontactid = s.contactid
left join #repair tmpR (nolock) on tmpR.parentcontactid = s.contactid
left join #MR tmpMR (nolock) on tmpMR.parentcontactid = s.contactid
left join #Nut tmpN (nolock) on tmpN.parentcontactid = s.contactid
left join #farm tmpF (nolock) on tmpF.parentcontactid = s.contactid

      --ServiceMgr
      LEFT JOIN
            (SELECT sm1.SiteContactID,c2.ContactName SiteName,sm2.ProdSvcMgrContactID,sm2.EffectiveDate,c.ContactID SrSvcContactID,c.ContactName SrSvcName
            FROM (
                        SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                        FROM CentralData.dbo.ProdSvcMgrAssignment 
                              GROUP BY SiteContactID) sm1
      LEFT JOIN CentralData.dbo.ProdSvcMgrAssignment sm2 ON sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
      LEFT JOIN CentralData.dbo.Contact c ON c.ContactID=sm2.ProdSvcMgrContactID
      LEFT JOIN CentralData.dbo.Contact c2 ON c2.ContactID=sm1.SiteContactID) SSM
      ON SSM.SiteContactID=s.ContactID
      
      --Production/Farm ServiceMgr
      LEFT JOIN
            (SELECT sm1.SiteContactID,c2.ContactName SiteName,sm2.SvcMgrContactID,sm2.EffectiveDate,c.ContactID SvcContactID,c.ContactName SvcMgrName
            FROM(
                  SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                  FROM CentralData.dbo.SiteSvcMgrAssignment 
                        GROUP BY SiteContactID) sm1
      LEFT JOIN CentralData.dbo.SiteSvcMgrAssignment sm2 ON sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
      LEFT JOIN CentralData.dbo.Contact c ON c.ContactID=sm2.SvcMgrContactID
      LEFT JOIN CentralData.dbo.Contact c2 ON c2.ContactID=sm1.SiteContactID) SM
      ON SM.SiteContactID=s.ContactID
      
      --MarketMgr
      LEFT JOIN
            (SELECT sm1.SiteContactID,c3.ContactName SiteName,sm3.MarketSvcMgrContactID,sm3.EffectiveDate,c.ContactID SvcContactID,c.ContactName MarketMgrName
            FROM(
                  SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                  FROM CentralData.dbo.MarketSvcMgrAssignment 
                        GROUP BY SiteContactID) sm1
      LEFT JOIN CentralData.dbo.MarketSvcMgrAssignment sm3 ON sm3.SiteContactID=sm1.SiteContactID and sm3.EffectiveDate=sm1.EffectiveDate
      LEFT JOIN CentralData.dbo.Contact c ON c.ContactID = sm3.MarketSvcMgrContactID
      LEFT JOIN CentralData.dbo.Contact c3 ON c3.ContactID = sm1.SiteContactID) MM
      ON MM.SiteContactID = s.ContactID
where p.project = 'ps8122'	-- ON farrowing
and p.LUpd_DateTime >=
              (SELECT DATEADD(hour,-1,max(endTIME)) AS LastExecution
              FROM [SCRIBEINTERNAL].[SCRIBE].[USERVIEW_EXECSBYDTS]
              WHERE DTS = 'PSProjects-Service Accounts IntegrationSP.dts'
              AND COLLABORATION = 'SL-CRM Prod')

END




















GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_CRM_project_services_extract_old] TO [MSDSL]
    AS [dbo];


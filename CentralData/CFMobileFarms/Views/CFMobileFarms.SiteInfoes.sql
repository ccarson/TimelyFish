


CREATE VIEW [cfmobilefarms].[SiteInfoes] 
AS
SELECT distinct
       s.SiteID as SiteID
       ,c.ContactID as ContactID
	   ,c.ContactTypeID as recordType
       ,case 
	    when c.ContactName like '_00%' then substring(c.ContactName,1,1) +substring(c.ContactName,4,len(c.ContactName))
    	 when c.ContactName like '_0%' then  substring(c.ContactName,1,1) +substring(c.ContactName,3,len(c.ContactName))
		else c.ContactName	
		end as 'Name'
	   ,isnull(c.EMailAddress, '') as 'email'
	   ,isnull(p.PhoneNbr, '') AS phone
	   ,a.Address1 as 'Address'
       ,a.City as City
       ,a.State as 'State'
       ,A.Zip as Zip
	   ,isnull(barncount.Barns, '') as Barns
       ,ft.FacilityTypeDescription as Phase
       ,isnull(sb.BioSecurityLevel,'') as 'Bio_Level'
       ,sot.SiteOwnershipDescription as Ownership
       ,ps.ProductionSystemDescription as PigSystem
       ,isnull(SSM.SrSvcName,'') as 'SM'
	   ,isnull(SSM.SrSvcContactID,'') as 'SMID'
	   ,isnull(svmp.phonenbr,'') as 'SM_Phone'
       ,isnull(SM.SvcMgrName,'') as 'Prod_Farm_Mgr'
	   ,isnull(SM.SvcMgrContactID,'') as 'Prod_Farm_MgrID'
	   ,isnull(pfsmp.phonenbr,'') as 'Prod_Farm_Mgr_Phone'
       ,isnull(MM.MarketMgrName,'') as 'Mkt_Mgr'
	   ,isnull(MM.MarketSvcMgrContactID,'') as 'Mkt_Mgr_ID'
	   ,isnull(mmp.phonenbr,'') as 'Mkt_Mgr_Phone'
       ,isnull(sitemgr.ContactName,'') as 'Site_Mgr'
	   ,isnull(sitemgr.ContactID,'') as 'Site_MgrID'
	   ,isnull(smp.phonenbr,'') as 'Site_Mgr_Phone'
       ,isnull(regionc.ContactName,'') as RegionName
       ,CONVERT(real, a.Longitude) as Longitude
       ,CONVERT(real, a.Latitude) as Latitude
	   ,CONVERT(nvarchar(128), s.SiteID) as Id
	   ,CONVERT(timestamp, null)  as Version 
	   ,sb.Crtd_DateTime as CreatedAt
	   ,sb.Crtd_DateTime as UpdatedAt
	   ,CONVERT(bit, 0) as Deleted
       
FROM dbo.Contact c 
       LEFT JOIN dbo.Site s on c.ContactID = s.ContactID
	   LEFT Join [dbo].[SiteBio] sb on s.[ContactID] = sb.[ContactID] and s.siteid = sb.siteid
       LEFT JOIN  dbo.ContactAddress ca on c.ContactID = ca.ContactID 
       LEFT JOIN  dbo.Address a on ca.AddressID = a.AddressID
	   left outer join 
            (   select contactid, phoneid, phonetypeid,ordr
                  from 
                   (  select contactid, phoneid, phonetypeid
                    , ROW_NUMBER() over (partition by contactid
                    order by 
                    case  when PhoneTypeID = 26 then 1
                          when PhoneTypeID = 27 then 2
						  when PhoneTypeID = 1 then 3 
                          when PhoneTypeID = 4 then 4
                          when PhoneTypeID = 3 then 5  
                          when PhoneTypeID = 19 then 6
                          when PhoneTypeID = 2 then 7
                          when PhoneTypeID = 15 then 8
                          when PhoneTypeID = 5 then 9
                          when PhoneTypeID = 6 then 10
						  when PhoneTypeID = 8 then 11
                          else  12 
                        end) ordr
                    from [dbo].[ContactPhone]) xx
                    where xx.ordr = 1 ) cp  ON c.ContactID = cp.ContactID 
	   LEFT OUTER JOIN dbo.Phone AS p (nolock) ON cp.PhoneID = p.PhoneID
       LEFT JOIN  dbo.SiteOwnershipType sot on sot.SiteOwnershipTypeID = s.OwnershipID
       LEFT JOIN  dbo.StatusType st on st.StatusTypeID = c.StatusTypeID
       LEFT JOIN  dbo.FacilityType ft on ft.FacilityTypeID = s.FacilityTypeID
       LEFT JOIN (SELECT c.ContactID, COUNT(b.BarnNbr) Barns from dbo.Barn b
              LEFT JOIN dbo.Site s on s.ContactID = b.ContactID
              LEFT JOIN dbo.Contact c on c.ContactID = s.ContactID
              GROUP BY c.contactid) barncount on barncount.ContactID = s.ContactID
       LEFT JOIN  dbo.ProductionSystem ps on ps.ProductionSystemID = s.PigSystemID
       
       --Region Name
       LEFT JOIN  dbo.RelatedContact rcx on rcx.ContactID = c.ContactID and rcx.SummaryOfDetail = 'Region'
       LEFT JOIN  dbo.Contact regionc (NOLOCK) on regionc.ContactID = rcx.RelatedID
       LEFT JOIN  dbo.RelatedContactDetail rcd (NOLOCK) on rcd.RelatedContactID = rcx.RelatedContactID
       LEFT JOIN  dbo.RelatedContactRelationshipType rcrt (NOLOCK) on rcrt.RelatedContactRelationshipTypeID = rcd.RelatedContactRelationshipTypeID
       
       --ServiceMgr
       LEFT JOIN
              (SELECT sm1.SiteContactID,c2.ContactName SiteName,sm2.ProdSvcMgrContactID,sm2.EffectiveDate,c1.ContactID SrSvcContactID,c1.ContactName SrSvcName
              FROM (
                           SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                           FROM  dbo.ProdSvcMgrAssignment 
                                  GROUP BY SiteContactID) sm1
       LEFT JOIN  dbo.ProdSvcMgrAssignment sm2 ON sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
       LEFT JOIN  dbo.Contact c1 ON c1.ContactID=sm2.ProdSvcMgrContactID
       LEFT JOIN  dbo.Contact c2 ON c2.ContactID=sm1.SiteContactID) SSM ON SSM.SiteContactID=s.ContactID
       
       --Production/Farm ServiceMgr
       LEFT JOIN
              (SELECT sm1.SiteContactID,c2.ContactName SiteName,sm2.SvcMgrContactID,sm2.EffectiveDate,c.ContactID SvcContactID,c.ContactName SvcMgrName
              FROM(
                     SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                     FROM  dbo.SiteSvcMgrAssignment 
                           GROUP BY SiteContactID) sm1
       LEFT JOIN  dbo.SiteSvcMgrAssignment sm2 ON sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
       LEFT JOIN  dbo.Contact c ON c.ContactID=sm2.SvcMgrContactID
       LEFT JOIN  dbo.Contact c2 ON c2.ContactID=sm1.SiteContactID) SM ON SM.SiteContactID=s.ContactID
       
       --MarketMgr
       LEFT JOIN
              (SELECT sm1.SiteContactID,c3.ContactName SiteName,sm3.MarketSvcMgrContactID,sm3.EffectiveDate,c.ContactID SvcContactID,c.ContactName MarketMgrName
              FROM(
                     SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                     FROM  dbo.MarketSvcMgrAssignment 
                           GROUP BY SiteContactID) sm1
       LEFT JOIN  dbo.MarketSvcMgrAssignment sm3 ON sm3.SiteContactID=sm1.SiteContactID and sm3.EffectiveDate=sm1.EffectiveDate
       LEFT JOIN  dbo.Contact c ON c.ContactID = sm3.MarketSvcMgrContactID
       LEFT JOIN  dbo.Contact c3 ON c3.ContactID = sm1.SiteContactID) MM ON MM.SiteContactID = s.ContactID

       --SiteMgr
       LEFT JOIN  dbo.Contact sitemgr (NOLOCK) ON sitemgr.ContactID = s.SiteMgrContactID
       
       --ServiceMgr phone 
	   left outer join 
            (   select contactid, phoneid, phonetypeid,ordr
                  from 
                   (  select contactid, phoneid, phonetypeid
                    , ROW_NUMBER() over (partition by contactid
                    order by 
                    case  when PhoneTypeID = 26 then 1
                          when PhoneTypeID = 27 then 2
						  when PhoneTypeID = 1 then 3 
                          when PhoneTypeID = 4 then 4
                          when PhoneTypeID = 3 then 5  
                          when PhoneTypeID = 19 then 6
                          when PhoneTypeID = 2 then 7
                          when PhoneTypeID = 15 then 8
                          when PhoneTypeID = 5 then 9
                          when PhoneTypeID = 6 then 10
						  when PhoneTypeID = 8 then 11
                          else  12 
                        end) ordr
                    from [dbo].[ContactPhone]) xx
                    where xx.ordr = 1 ) svmphone  ON SSM.SrSvcContactID = svmphone.ContactID 
	   LEFT OUTER JOIN dbo.Phone AS svmp (nolock) ON svmphone.PhoneID = svmp.PhoneID
       --Production/Farm ServiceMgr
	   left outer join 
            (   select contactid, phoneid, phonetypeid,ordr
                  from 
                   (  select contactid, phoneid, phonetypeid
                    , ROW_NUMBER() over (partition by contactid
                    order by 
                    case  when PhoneTypeID = 26 then 1
                          when PhoneTypeID = 27 then 2
						  when PhoneTypeID = 1 then 3 
                          when PhoneTypeID = 4 then 4
                          when PhoneTypeID = 3 then 5  
                          when PhoneTypeID = 19 then 6
                          when PhoneTypeID = 2 then 7
                          when PhoneTypeID = 15 then 8
                          when PhoneTypeID = 5 then 9
                          when PhoneTypeID = 6 then 10
						  when PhoneTypeID = 8 then 11
                          else  12 
                        end) ordr
                    from [dbo].[ContactPhone]) xx
                    where xx.ordr = 1 ) pfsmphone  ON SM.SvcContactID = pfsmphone.ContactID 
	   LEFT OUTER JOIN dbo.Phone AS pfsmp (nolock) ON pfsmphone.PhoneID = pfsmp.PhoneID
       --MarketMgr phone   
	   left outer join 
            (   select contactid, phoneid, phonetypeid,ordr
                  from 
                   (  select contactid, phoneid, phonetypeid
                    , ROW_NUMBER() over (partition by contactid
                    order by 
                    case  when PhoneTypeID = 26 then 1
                          when PhoneTypeID = 27 then 2
						  when PhoneTypeID = 1 then 3 
                          when PhoneTypeID = 4 then 4
                          when PhoneTypeID = 3 then 5  
                          when PhoneTypeID = 19 then 6
                          when PhoneTypeID = 2 then 7
                          when PhoneTypeID = 15 then 8
                          when PhoneTypeID = 5 then 9
                          when PhoneTypeID = 6 then 10
						  when PhoneTypeID = 8 then 11
                          else  12 
                        end) ordr
                    from [dbo].[ContactPhone]) xx
                    where xx.ordr = 1 ) mmphone  ON MM.SvcContactID = mmphone.ContactID   
	   LEFT OUTER JOIN dbo.Phone AS mmp (nolock) ON mmphone.PhoneID = mmp.PhoneID
       --SiteMgr phone
	   left outer join 
            (   select contactid, phoneid, phonetypeid,ordr
                  from 
                   (  select contactid, phoneid, phonetypeid
                    , ROW_NUMBER() over (partition by contactid
                    order by 
                    case  when PhoneTypeID = 26 then 1
                          when PhoneTypeID = 27 then 2
						  when PhoneTypeID = 1 then 3 
                          when PhoneTypeID = 4 then 4
                          when PhoneTypeID = 3 then 5  
                          when PhoneTypeID = 19 then 6
                          when PhoneTypeID = 2 then 7
                          when PhoneTypeID = 15 then 8
                          when PhoneTypeID = 5 then 9
                          when PhoneTypeID = 6 then 10
						  when PhoneTypeID = 8 then 11
                          else  12 
                        end) ordr
                    from [dbo].[ContactPhone]) xx
                    where xx.ordr = 1 ) smphone  ON sitemgr.ContactID = smphone.ContactID 
 	   LEFT OUTER JOIN dbo.Phone AS smp (nolock) ON smphone.PhoneID = smp.PhoneID

WHERE
c.ContactTypeID IN (1, 4) AND c.StatusTypeID = 1
AND s.Siteid not in ('9999','1660','8000','8010','0001')
AND ca.AddressTypeID = 1
--AND ft.FacilityTypeDescription <> 'non-production'



GO
GRANT SELECT
    ON OBJECT::[CFMobileFarms].[SiteInfoes] TO [hybridconnectionlogin_permissions]
    AS [HybridConnectionLogin];







CREATE VIEW [CFMobileFarms].[LocationInfoes] 
AS
SELECT distinct
       isnull(s.SiteID, c.ContactID) as SiteID
       ,c.ContactID as LocationContactID
	   ,c.ContactTypeID as recordType
	   --,isnull(rt.RoleTypeDescription, 'Site') as LocationType
	   ,isnull(ft.FacilityTypeDescription, 'Farm') as LocationType
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
	   ,A.Township as Township
	   ,isnull(barncount.Barns, '') as Barns
       ,isnull(ft.FacilityTypeDescription, '') as Phase
       ,isnull(sb.BioSecurityLevel,'') as 'Bio_Level'
       ,sot.SiteOwnershipDescription as Ownership
       ,ps.ProductionSystemDescription as PigSystem
       ,isnull(regionc.ContactName,'') as RegionName
       ,CONVERT(real, a.Longitude) as Longitude
       ,CONVERT(real, a.Latitude) as Latitude
	   ,CONVERT(nvarchar(128), s.ContactID) as Id
	   ,CONVERT(timestamp, null)  as Version 
	   ,CONVERT(DATETIMEOFFSET, CONVERT(VARCHAR, sb.Crtd_DateTime, 120) + 
          RIGHT(CONVERT(VARCHAR, SYSDATETIMEOFFSET(), 120), 6), 120) as CreatedAt
	   ,CONVERT(DATETIMEOFFSET, CONVERT(VARCHAR, sb.Crtd_DateTime, 120) + 
          RIGHT(CONVERT(VARCHAR, SYSDATETIMEOFFSET(), 120), 6), 120) as UpdatedAt
	   ,CONVERT(bit, 0) as Deleted
       
FROM dbo.Contact c 
       LEFT JOIN dbo.Site s on c.ContactID = s.ContactID
	   LEFT JOIN [dbo].[SiteBio] sb on s.[ContactID] = sb.[ContactID] and s.siteid = sb.siteid
       LEFT JOIN  dbo.ContactAddress ca on c.ContactID = ca.ContactID 
       LEFT JOIN  dbo.Address a on ca.AddressID = a.AddressID
	   LEFT JOIN 
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
	   LEFT JOIN dbo.Phone AS p (nolock) ON cp.PhoneID = p.PhoneID
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
       
	   LEFT JOIN dbo.ContactRoleType crt on c.contactid = crt.contactID
	   LEFT JOIN dbo.RoleType rt on crt.RoleTypeID = rt.RoleTypeID
       
WHERE
	c.ContactTypeID =4 AND c.StatusTypeID = 1
	AND s.Siteid NOT IN ('9999','1660','8000','8010','0001')
	AND ca.AddressTypeID = 1
	
UNION

SELECT distinct
       '' AS SiteID
       ,c.ContactID as LocationContactID
	   ,c.ContactTypeID as recordType
	   ,rt.RoleTypeDescription as locationType
       ,c.ContactName  as 'Name'
	   ,isnull(c.EMailAddress, '') as 'email'
	   ,isnull(p.PhoneNbr, '') AS phone
	   ,a.Address1 as 'Address'
       ,a.City as City
       ,a.State as 'State'
       ,A.Zip as Zip
	   ,A.Township as Township
	   ,'' as Barns
       ,'' as Phase
       ,'None' as 'Bio_Level'
       ,'' as Ownership
       ,'' as PigSystem
	   ,'' as RegionName
       ,CONVERT(real, a.Longitude) as Longitude
       ,CONVERT(real, a.Latitude) as Latitude
	   ,CONVERT(nvarchar(128), c.ContactID) as Id
	   ,CONVERT(timestamp, null)  as Version 
	   ,CONVERT(datetimeoffset(7), null) as CreatedAt
	   ,CONVERT(datetimeoffset(7), null) as UpdatedAt
	   ,CONVERT(bit, 0) as Deleted
       
FROM dbo.Contact c 
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
       LEFT JOIN [dbo].[ContactRoleType] crt on c.contactid = crt.contactID
	   LEFT JOIN [dbo].[RoleType] rt on crt.RoleTypeID = rt.RoleTypeID
     

WHERE c.ContactTypeID = 1 AND c.StatusTypeID = 1
AND ca.AddressTypeID = 1 
and crt.RoleTypeID in (10, 21,3, 20, 34, 35) 
and Longitude is not null

	--order by contactID





GO
GRANT SELECT
    ON OBJECT::[CFMobileFarms].[LocationInfoes] TO [hybridconnectionlogin_permissions]
    AS [HybridConnectionLogin];


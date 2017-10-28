CREATE VIEW [dbo].[CRMAccountView] 
AS
SELECT 
		CRM.[CDName] as CRMName
		,CRM.[CRMGuid] as CRMGuid
       ,s.SiteID as SiteID
       ,c.ContactID as ContactID
       ,c.ContactName as Name
	   ,c.ShortName as shortName
	   , case c.[TranSchedMethodTypeID]
		WHEN 2 Then 'E-mail'
		WHEN 3 Then 'Fax'
		When 4 THen 'Print'
		else 'None'
		End as TransSchedMethod
	   ,isnull(c.EMailAddress, '') as 'email'
	   ,isnull(p.PhoneNbr, '') AS phone
	   ,isnull(fax.PhoneNbr, '') AS faxx
	   ,a.Address1 as 'Address'
       ,a.City as City
       ,a.State as 'State'
       ,A.Zip as Zip
	   ,a.Country as country
	   ,a.County
	   ,a.Township
	   ,a.SectionNbr
	   ,a.[Range] as 'Range'
	   ,a2.Address1 as 'MAddress'
       ,a2.City as MCity
       ,a2.State as 'MState'
       ,A2.Zip as MZip
       ,ft.FacilityTypeDescription as Phase
	   ,CRMFT.ID as FacilityCode
       ,isnull(sb.BioSecurityLevel,'') as 'Bio_Level'
	   ,bst.[BioID] as BioID
       ,sot.SiteOwnershipDescription as Ownership
	   ,Case sot.SiteOwnershipDescription
			When 'Company' THEN 224310000
			When 'Contract' THEN 224310001
			When 'Company Managed' THEN 224310002
			When 'Employee' THEN 224310003
			When 'Non-CFF' THEN 224310004
			When 'Contract/Sublet' THEN 224310005
			When 'Company/Sublet' THEN 224310006
			When 'Managed/DCC' THEN 224310007
			When 'Managed/TNL' THEN 224310008
			ELSE 224310000
		END as ownershipCode
       ,ps.ProductionSystemDescription as PigSystem
       ,CONVERT(real, a.Longitude) as Longitude
       ,CONVERT(real, a.Latitude) as Latitude

       
FROM dbo.Contact c 
       LEFT JOIN dbo.Site s on c.ContactID = s.ContactID
	   LEft join [$(CFFDB)].[dbo].[CRMtoCDEntity] CRM on cast(C.ContactID as Int) = CRM.CDContactID
	   LEFT Join [dbo].[SiteBio] sb on s.[ContactID] = sb.[ContactID] and s.siteid = sb.siteid
	   LEFT Join [$(CFFDB)].[dbo].[CRMBioSecurityType] bst on sb.BioSecurityLevel = bst.[description]
       LEFT JOIN  dbo.ContactAddress ca on c.ContactID = ca.ContactID and ca.AddressTypeID = 1
       LEFT JOIN  dbo.Address a on ca.AddressID = a.AddressID 
	   LEFT JOIN  dbo.ContactAddress ca2 on c.ContactID = ca2.ContactID and ca2.AddressTypeID = 2
       LEFT JOIN  dbo.Address a2 on ca2.AddressID = a2.AddressID 
	   LEFT JOIN [dbo].[ContactPhone] cf on c.ContactID = cf.ContactID and cf.PhoneTypeID = 7
	   LEFT JOIN dbo.Phone AS fax (nolock) ON cf.PhoneID = fax.PhoneID
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
	   LEFT JOIN [$(CFFDB)].[dbo].[CRMFacilityType] CRMFT on ft.FacilityTypeDescription = CRMFT.[Description]
       

WHERE
c.ContactTypeID = 4 AND c.StatusTypeID = 1
AND s.Siteid not in ('9999','1660','8000','8010','0001')

--AND ft.FacilityTypeDescription <> 'non-production'








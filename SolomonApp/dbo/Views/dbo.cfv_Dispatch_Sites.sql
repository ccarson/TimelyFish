
-- ==========================================================================================================
-- Date			Author				Change Description
-- ----------   ------------------	-------------------------------------------------------------------------
-- 6/01/2016	ddahle				Created new view, like cfvSite, to only show active sites.
--									Used in VFD Dispatch app for Pronto Forms
--
-- ==========================================================================================================
CREATE View [dbo].[cfv_Dispatch_Sites] (Addr1, Addr2, City, ContactId, ContactName, County, EMailAddress, MillId, SiteId, State, Zip,Phone, Email, Phase, Tstamp) as

    Select a.Address1, a.Address2, a.City, c.ContactId, c.ContactName, 
	a.County, c.EMailAddress, IsNull(s.ContactId,''), s.SiteId, 
	a.State, a.Zip
	,isnull(p.PhoneNbr, '') AS phone
	,isnull(c.EMailAddress, '') as Email 
	,ft.[Description] as Phase, c.tstamp
	from cftSite s 
		JOIN cftContact c on c.ContactId = s.ContactId 
		JOIN cftContactAddress ca ON c.ContactID = ca.ContactID AND ca.AddressTypeID = 1
		JOIN cftAddress a on ca.AddressID = a.AddressID 
		JOIN cftFacilityType ft on s.FacilityTypeID=ft.FacilityTypeID
		left outer join 
            (   select contactid, phoneid, phonetypeid,ordr
                  from 
                   (  select contactid, phoneid, phonetypeid
                    , ROW_NUMBER() over (partition by contactid
                    order by 
                    case  when PhoneTypeID = '026' then 1
                          when PhoneTypeID = '027' then 2
						  when PhoneTypeID = '001' then 3 
                          when PhoneTypeID = '004' then 4
                          when PhoneTypeID = '003' then 5  
                          when PhoneTypeID = '019' then 6
                          when PhoneTypeID = '002' then 7
                          when PhoneTypeID = '015' then 8
                          when PhoneTypeID = '005' then 9
                          when PhoneTypeID = '006' then 10
						  when PhoneTypeID = '008' then 11
                          else  12 
                        end) ordr
                    from cftContactPhone) xx
                    where xx.ordr = 1 ) cp  ON c.ContactID = cp.ContactID 
	   LEFT OUTER JOIN dbo.cftPhone AS p (nolock) ON cp.PhoneID = p.PhoneID
	WHERE c.StatusTypeID = 1

 





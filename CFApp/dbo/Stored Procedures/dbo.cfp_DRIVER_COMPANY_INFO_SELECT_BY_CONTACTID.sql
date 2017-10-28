-- =============================================
-- Author:		Dave Killion
-- Create date: 11/8/2007
-- Description:	Returns information used in the Driver Maintenance screen
-- Filters for fax phone numbers (phonetypeid = 7)
-- Filters for physical address (addresstypeid = 1)
-- Change:  Added TQA, MobileAccess (ddahle) 7/23/2015
-- =============================================
CREATE PROCEDURE [dbo].[cfp_DRIVER_COMPANY_INFO_SELECT_BY_CONTACTID]
	-- Add the parameters for the stored procedure here
	@Contactid int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select 
	contact.contactid
	,contact.StatusTypeID
	,contact.ContactTypeID
	,contact.TranSchedMethodTypeID
	,Contact.ContactName TruckingCompanyName
	,Contact.ContactName
	,Contact.ContactFirstName
	,Contact.ContactMiddleName
	,Contact.ContactLastName
	,Contact.EmailAddress 
	,Contact.ShortName
	,phone.phonenbr Fax
	,phone.PhoneID FaxID
	,isnull(p.PhoneNbr, '') AS Phone
	,isnull(p.PhoneID, '') AS PhoneID
	,address.address1 StreetAddress
	,address.city
	,address.state
	,address.zip
	,address.Longitude
	,address.Latitude
	,address.AddressID as AddressID
	,ct.ContactTypeDescription
	,dci.SelectedStatus as ScheduleTypeID
	,dci.TruckCompanyComments as ContactComments
	,ra.ParentContactID as TruckingCompanyContactID
	,isnull(cc.ContactName, '') as TruckingCompanyName
	,pm.[PermitID]
	,pm.[PermitNbr] as TQA
	,contact.MobileAccess
from [$(CentralData)].dbo.Contact Contact (NOLOCK)
left outer join 
            (   select contactid, phoneid, phonetypeid,ordr
                  from 
                   (  select contactid, phoneid, phonetypeid
                    , ROW_NUMBER() over (partition by contactid
                    order by 
                    case  when PhoneTypeID = 7 then 1
                          when PhoneTypeID = 13 then 2
                          else  3
                        end) ordr
                    from [$(CentralData)].[dbo].[ContactPhone]) xx
                    where xx.ordr = 1 ) ContactPhone  ON Contact.ContactID = ContactPhone.ContactID 

left join [$(CentralData)].dbo.Phone Phone (NOLOCK) on phone.phoneid = contactphone.phoneid 
left join [$(CentralData)].dbo.ContactAddress ContactAddress (NOLOCK) on contactaddress.contactid = contact.contactid and addresstypeid = 1
left join [$(CentralData)].dbo.Address Address (NOLOCK) on address.addressid = contactaddress.addressid
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
                    from [$(CentralData)].[dbo].[ContactPhone]) xx
                    where xx.ordr = 1 ) cp  ON Contact.ContactID = cp.ContactID 
	   LEFT OUTER JOIN [$(CentralData)].dbo.Phone AS p (nolock) ON cp.PhoneID = p.PhoneID
	   LEFT JOIN [$(CentralData)].[dbo].[ContactType] as ct (NOLOCK) ON Contact.ContactTypeID = ct.ContactTypeID
	   LEFT JOIN [dbo].[cft_DRIVER_COMPANY_INFO] as dci (NOLOCK) on Contact.ContactID = dci.ContactID
	   LEFT JOIN [$(CentralData)].[dbo].[cftRelationshipAssignment] as ra (NOLOCK) on Contact.ContactID = ra.ChildContactID and ra.EndDate is NULL 
	   LEFT JOIN [$(CentralData)].dbo.Contact as cc (NOLOCK) on ra.ParentContactID = cc.ContactID
	   LEFT JOIN [$(CentralData)].[dbo].[Permit] as pm (NOLOCK) on Contact.ContactID = pm.[SiteContactID] and pm.[PermitTypeID] = 35
where
	contact.contactid = @Contactid
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DRIVER_COMPANY_INFO_SELECT_BY_CONTACTID] TO [db_sp_exec]
    AS [dbo];


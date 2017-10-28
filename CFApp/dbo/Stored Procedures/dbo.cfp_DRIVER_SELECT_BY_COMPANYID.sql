-- =============================================
-- Author:		Doran Dahle
-- Create date: 07/28/2015
-- Description:	Returns a list of Drivers by CompanyID
-- =============================================
create PROCEDURE [dbo].[cfp_DRIVER_SELECT_BY_COMPANYID]
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
	,ContactRoleType.RoleTypeID
	,rt.RoleTypeDescription
	,ct.ContactTypeDescription
	,dci.SelectedStatus as ScheduleTypeID
	,dci.TruckCompanyComments as ContactComments
	--,dci.TrailerID as PigTrailerID
	--,ptr.Description as TrailerNumber
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
	   LEFT JOIN [$(CentralData)].dbo.ContactRoleType ContactRoleType (NOLOCK)
		ON Contact.ContactID = ContactRoleType.ContactID
       LEFT Join [$(CentralData)].[dbo].[RoleType] as rt (NOLOCK) ON ContactRoleType.RoleTypeID = rt.RoleTypeID
	   LEFT JOIN [$(CentralData)].[dbo].[ContactType] as ct (NOLOCK) ON Contact.ContactTypeID = ct.ContactTypeID
	   LEFT JOIN [dbo].[cft_DRIVER_COMPANY_INFO] as dci (NOLOCK) on Contact.ContactID = dci.ContactID
	   --LEFT JOIN [$(SolomonApp)].[dbo].[cftPigTrailer] as ptr (NOLOCK) on dci.TrailerID = ptr.PigTrailerID
	   LEFT JOIN [$(CentralData)].[dbo].[cftRelationshipAssignment] as ra (NOLOCK) on Contact.ContactID = ra.ChildContactID and ra.EndDate is NULL 
	   LEFT JOIN [$(CentralData)].dbo.Contact as cc (NOLOCK) on ra.ParentContactID = cc.ContactID
	   LEFT JOIN [$(CentralData)].[dbo].[Permit] as pm (NOLOCK) on Contact.ContactID = pm.[SiteContactID] and pm.[PermitTypeID] = 34
where
	ra.ParentContactID = @Contactid 
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DRIVER_SELECT_BY_COMPANYID] TO [db_sp_exec]
    AS [dbo];


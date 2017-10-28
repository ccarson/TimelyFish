-- =============================================
-- Author:		Doran Dahle
-- Create date: 07/7/2015
-- Description:	Returns all contacts that are truck Drivers.  Returns only Individuals
-- =============================================
Create PROCEDURE [dbo].[cfp_CONTACT_SELECT_Drivers]
(
	@RoleTypeID1		int
	, @RoleTypeID2		int
	, @RoleTypeID3		int
)
AS
BEGIN
	SET NOCOUNT ON;

select Distinct
	contact.contactid
	,contact.StatusTypeID
	,contact.ContactTypeID
	,ct.ContactTypeDescription
	,Contact.ContactName
	,Contact.ShortName
	,Contact.ContactFirstName
	,Contact.ContactMiddleName
	,Contact.ContactLastName
	,Contact.EmailAddress
	,phone.phonenbr Fax
	,isnull(p.PhoneNbr, '') AS Phone
	,address.city
	,address.state
	--,ContactRoleType.RoleTypeID
	--,rt.RoleTypeDescription
	,ra.ParentContactID as TruckingCompanyContactID
	,isnull(cc.ContactName, '') as TruckingCompanyName
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
	   --LEFT JOIN [$(CentralData)].dbo.ContactRoleType ContactRoleType (NOLOCK) ON Contact.ContactID = ContactRoleType.ContactID
       --LEFT Join [$(CentralData)].[dbo].[RoleType] as rt (NOLOCK) ON ContactRoleType.RoleTypeID = rt.RoleTypeID
	   LEFT JOIN [$(CentralData)].[dbo].[ContactType] as ct (NOLOCK) ON Contact.ContactTypeID = ct.ContactTypeID
	   LEFT JOIN [$(CentralData)].[dbo].[cftRelationshipAssignment] as ra (NOLOCK) on Contact.ContactID = ra.ChildContactID and ra.EndDate is NULL 
	   LEFT JOIN [$(CentralData)].dbo.Contact as cc (NOLOCK) on ra.ParentContactID = cc.ContactID
	WHERE Contact.ContactID in (select distinct CRT.ContactID from [$(CentralData)].dbo.ContactRoleType CRT where CRT.RoleTypeID in (@RoleTypeID1, @RoleTypeID2, @RoleTypeID3))
	and contact.ContactTypeID = 3
	ORDER BY Contact.ContactName
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_SELECT_Drivers] TO [db_sp_exec]
    AS [dbo];


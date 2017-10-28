-- =============================================
-- Author:		Doran Dahle
-- Create date: 08/20/2015
-- Description:	Returns all contacts that are truckers by role and Active
-- =============================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_SELECT_TRUCK_COMPANIES]

AS
BEGIN
	SET NOCOUNT ON;

select Distinct
	contact.contactid
	,contact.StatusTypeID
	,contact.ContactName
	,contact.ShortName
	,address.city
	,address.state
	,ContactRoleType.RoleTypeID
	
from [$(CentralData)].dbo.Contact contact (NOLOCK)
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

	   LEFT JOIN [$(CentralData)].dbo.ContactRoleType ContactRoleType (NOLOCK) ON Contact.ContactID = ContactRoleType.ContactID
	   
	WHERE ContactRoleType.RoleTypeID in (2,11,12)
	and contact.ContactTypeID = 1
	and contact.StatusTypeID = 1
	ORDER BY Contact.ContactName
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_SELECT_TRUCK_COMPANIES] TO [db_sp_exec]
    AS [dbo];


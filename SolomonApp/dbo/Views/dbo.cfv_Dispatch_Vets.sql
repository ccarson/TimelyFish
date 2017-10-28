


CREATE   VIEW [dbo].[cfv_Dispatch_Vets] (VetId, Address1, Address2, AddressID, City, ContactName, State, Zip,Phone, Email, Tstamp)
	AS
/* Used in the VFD Dispatch programs
*/
	-- This view is used to display a list of contacts 
	-- that have the contact role of 'Veterinarian' (RoleTypeID = 001)
	SELECT c.ContactID,Coalesce(a.Address1, ''), Coalesce(a.Address2, ''), Coalesce(a.AddressID, ''), 
		Coalesce(a.City, ''), c.ContactName, 
		 Coalesce(a.State, ''), Coalesce(a.Zip, '')
		,isnull(p.PhoneNbr, '') AS phone
		,isnull(c.EMailAddress, '') as Email,c.tstamp
		FROM
		cftContact c
		JOIN cftContactRoleType rt ON c.ContactID = rt.ContactID
		Left JOIN cftContactAddress ca ON c.ContactID = ca.ContactID AND ca.AddressTypeID = 1
		Left JOIN cftAddress a on ca.AddressID = a.AddressID 
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
		WHERE rt.RoleTypeID = '001' and c.StatusTypeId = '1'





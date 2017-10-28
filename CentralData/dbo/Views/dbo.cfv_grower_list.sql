
CREATE VIEW [dbo].[cfv_grower_list]
AS
SELECT contact.ContactID,
       ContactFirstName,
       ContactLastName, 
       address1,
       City,
       state,
       zip,
       phonenbr,
       case roletypeid when 13 then 'Grower' else 'IC' end group_name,
      'NoReply'+cast(row_number() over (order by contact.contactid) as varchar)+'@christensenfarms.com' email
  FROM Contact
  inner join ContactRoleType on contact.contactid=contactroletype.contactid and roletypeid in (13,26)
  left join ContactAddress on contact.contactid=contactaddress.contactid and addresstypeid=1
  left join address on address.addressid=contactaddress.addressid
  left join contactphone on contact.contactid=contactphone.contactid 
            and phonetypeid = (select top 1 phonetypeid 
                                from contactphone 
                                where contactid=contact.contactid and phonetypeid not in (7,13,14,15,16,17,20,21,22,23,24)
                                order by phonetypeid desc)
  left join phone on contactphone.phoneid=phone.phoneid
  where statustypeid=1 and ContactFirstName is not null


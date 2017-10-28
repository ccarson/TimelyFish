
CREATE VIEW dbo.cfv_CONTACT_PHONES
AS
SELECT  ContactPhone.ContactID, 
	ContactPhone.PhoneTypeID, 
	Phone.PhoneNbr
FROM		[$(CentralData)].dbo.ContactPhone ContactPhone (NOLOCK)
INNER JOIN	[$(CentralData)].dbo.Phone Phone (NOLOCK)
	ON ContactPhone.PhoneID = Phone.PhoneID



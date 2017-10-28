
CREATE VIEW [dbo].[cfv_CONTACT_PHONES]
AS
SELECT  ContactPhone.ContactID, 
      ContactPhone.PhoneTypeID, 
      Phone.PhoneNbr,
      cft_CONTACT_CELL_PHONE_PROVIDER.CarrierName,
      cft_CONTACT_CELL_PHONE_PROVIDER.CarrierTextMessageAddress
FROM        dbo.ContactPhone ContactPhone (NOLOCK)
INNER JOIN  dbo.Phone Phone (NOLOCK)
      ON ContactPhone.PhoneID = Phone.PhoneID
LEFT OUTER JOIN dbo.cft_CONTACT_CELL_PHONE_PROVIDER cft_CONTACT_CELL_PHONE_PROVIDER (NOLOCK)
      ON cft_CONTACT_CELL_PHONE_PROVIDER.CarrierID = ContactPhone.PhoneCarrierID

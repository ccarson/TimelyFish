

-- ===================================================================
-- Author:  Brian Cesafsky
-- Create date: 12/26/2007
-- Description:   selects all contact communicaton information records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_COMMUNICATION_INFO_SELECT]
AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

      SELECT      
            Contact.ContactID,
            Contact.ContactFirstName,
            Contact.ContactMiddleName,
            Contact.ContactLastName,
            Contact.ContactName,
            Contact.EMailAddress,
            ContactMainPhone.PhoneNbr 'MainPhone',
            ContactHomePhone.PhoneNbr 'HomePhone',
            ContactCellPhone.PhoneNbr 'CellPhone',
            ContactFax.PhoneNbr 'FaxNumber',
            ContactFaxTransportation.PhoneNbr 'FaxTransportationNumber',
            Contact.ContactTypeID
      FROM        [$(CentralData)].dbo.Contact Contact (NOLOCK)
      LEFT OUTER JOIN   [$(CentralData)].dbo.cfv_CONTACT_PHONES ContactMainPhone
            ON    ContactMainPhone.ContactID = Contact.ContactID
            AND   ContactMainPhone.PhoneTypeID = 1 --main phone
      LEFT OUTER JOIN   [$(CentralData)].dbo.cfv_CONTACT_PHONES ContactHomePhone
            ON    ContactHomePhone.ContactID = Contact.ContactID
            AND   ContactHomePhone.PhoneTypeID = 2 --home phone
      LEFT OUTER JOIN   [$(CentralData)].dbo.cfv_CONTACT_PHONES ContactCellPhone
            ON    ContactCellPhone.ContactID = Contact.ContactID
            AND   ContactCellPhone.PhoneTypeID = 3 --cell phone
      LEFT OUTER JOIN   [$(CentralData)].dbo.cfv_CONTACT_PHONES ContactFax
            ON    ContactFax.ContactID = Contact.ContactID
            AND   ContactFax.PhoneTypeID = 7 --fax
      LEFT OUTER JOIN   [$(CentralData)].dbo.cfv_CONTACT_PHONES ContactFaxTransportation
            ON    ContactFaxTransportation.ContactID = Contact.ContactID
            AND   ContactFaxTransportation.PhoneTypeID = 13 --fax transportation
END





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_COMMUNICATION_INFO_SELECT] TO [db_sp_exec]
    AS [dbo];


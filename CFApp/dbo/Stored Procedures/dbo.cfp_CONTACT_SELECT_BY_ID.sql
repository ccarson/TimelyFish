
-- =============================================
-- Author:  mdawson
-- Create date: 11/23/2007
-- Description:   selects contact information
-- =============================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_SELECT_BY_ID]
@ContactID int
AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

      SELECT      
            Contact.ContactID
            ,Contact.ContactName
            ,Contact.ContactTypeID
            ,Contact.Title
            ,Contact.ContactFirstName
            ,Contact.ContactMiddleName
            ,Contact.ContactLastName      
            ,Contact.EMailAddress
            ,Contact.TranSchedMethodTypeID
            --,Contact.DefaultContactMethodID
            ,Contact.StatusTypeID
            ,Contact.SolomonContactID
            ,Contact.ShortName
      FROM [$(CentralData)].dbo.Contact Contact (NOLOCK)
      WHERE Contact.ContactID = @ContactID
      ORDER BY Contact.ContactName
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];


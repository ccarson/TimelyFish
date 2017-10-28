
-- =============================================
-- Author:  ddahle
-- Create date: 7/13/2015
-- Description:   Checks for a shortname exists
-- =============================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_SHORTNAME_CHECK]
@shortName varchar(30),
@ContactID int
AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;
      SELECT count(*) as useCount
      FROM [$(CentralData)].dbo.Contact Contact (NOLOCK)
      WHERE Contact.ShortName like @shortName
	  and Contact.ContactID <> @ContactID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_SHORTNAME_CHECK] TO [db_sp_exec]
    AS [dbo];


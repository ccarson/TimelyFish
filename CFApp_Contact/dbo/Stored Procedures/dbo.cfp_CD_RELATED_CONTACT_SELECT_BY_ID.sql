
-- ==============================================================================
-- Author:		DDahle
-- Create date: 09/08/2015
-- Description:	CENTRAL DATA - Returns  Related contact information for a related contact
-- ==============================================================================
CREATE PROCEDURE [dbo].[cfp_CD_RELATED_CONTACT_SELECT_BY_ID]
(
	@ContactID								int
)
AS
BEGIN
	SET NOCOUNT ON;

SELECT [RelatedContactID]
      ,[RelatedID]
      ,[ContactID]
      ,[SummaryOfDetail]
  FROM  [$(CentralData)].dbo.RelatedContact
  where RelatedContact.ContactID = @ContactID

END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_RELATED_CONTACT_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];


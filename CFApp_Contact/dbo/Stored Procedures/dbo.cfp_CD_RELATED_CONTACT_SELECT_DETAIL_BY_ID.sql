
-- ==============================================================================
-- Author:		DDahle
-- Create date: 09/08/2015
-- Description:	CENTRAL DATA - Returns  Related contact detail information for a related contact
-- ==============================================================================
CREATE PROCEDURE [dbo].[cfp_CD_RELATED_CONTACT_SELECT_DETAIL_BY_ID]
(
	@RelatedContactID		int
)
AS
BEGIN
	SET NOCOUNT ON;

SELECT [RelatedContactDetailID]
      ,[RelatedContactID]
      ,[RelatedContactRelationshipTypeID]
      ,[Comments]
      ,[AccountNbr]
  FROM [$(CentralData)].[dbo].[RelatedContactDetail]
  Where [RelatedContactID] = @RelatedContactID

END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_RELATED_CONTACT_SELECT_DETAIL_BY_ID] TO [db_sp_exec]
    AS [dbo];


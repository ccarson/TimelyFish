
-- ==============================================================================
-- Author:		DDahle
-- Create date: 09/08/2015
-- Description:	CENTRAL DATA - Deletes a related contact detail
-- ==============================================================================
CREATE PROCEDURE [dbo].[cfp_CD_RELATED_CONTACT_DETAIL_DELETE]
(
	@RelatedContactID int
	,@RelatedContactRelationshipTypeID int
)
AS
BEGIN
	SET NOCOUNT ON;


DELETE FROM [$(CentralData)].[dbo].[RelatedContactDetail]
 WHERE [RelatedContactID] = @RelatedContactID
 AND RelatedContactRelationshipTypeID = @RelatedContactRelationshipTypeID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_RELATED_CONTACT_DETAIL_DELETE] TO [db_sp_exec]
    AS [dbo];


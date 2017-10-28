
-- ==============================================================================
-- Author:		DDahle
-- Create date: 09/08/2015
-- Description:	CENTRAL DATA - Updates a related contact
-- ==============================================================================
CREATE PROCEDURE [dbo].[cfp_CD_RELATED_CONTACT_UPDATE]
(
	@RelatedContactID int
	,@SummaryOfDetail varchar(200)
)
AS
BEGIN
	SET NOCOUNT ON;


UPDATE [$(CentralData)].[dbo].[RelatedContact]
   SET [SummaryOfDetail] = @SummaryOfDetail
 WHERE RelatedContactID = @RelatedContactID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_RELATED_CONTACT_UPDATE] TO [db_sp_exec]
    AS [dbo];


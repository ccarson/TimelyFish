-- =========================================================
-- Author:		Brian Cesafsky
-- Create date: 01/10/2011
-- Description:	Returns Feed Rations by Pig Group
-- =========================================================
CREATE PROCEDURE [dbo].[cfp_PACKER_BYPASS_SELECT_FEED_RATION_BY_PIG_GROUP]
(
	@PigGroupID		varchar(10)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT DISTINCT InvtIdDel
	FROM [$(SolomonApp)].dbo.cftFeedOrder (NOLOCK)
	WHERE PigGroupId = @PigGroupID   
	AND Reversal='0'
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_BYPASS_SELECT_FEED_RATION_BY_PIG_GROUP] TO [db_sp_exec]
    AS [dbo];


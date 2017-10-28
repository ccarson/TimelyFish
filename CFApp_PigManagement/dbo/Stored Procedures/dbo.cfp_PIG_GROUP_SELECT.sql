-- =====================================================================
-- Author:		Brian Cesafsky
-- Create date: 06/30/2008
-- Description:	Returns the active Pig Group
-- =====================================================================
CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_SELECT]
(
	@SiteContactID		int,
	@BarnID				int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT  PigGroup.PigGroupID 
	FROM [$(SolomonApp)].dbo.cftPigGroup PigGroup (NOLOCK)
	LEFT OUTER JOIN [$(CentralData)].dbo.Barn Barn (NOLOCK)
				ON RTRIM(Barn.BarnNbr) = RTRIM(PigGroup.BarnNbr)
	WHERE PigGroup.SiteContactID = @SiteContactID
	AND   Barn.BarnID = @BarnID
	AND   PGStatusID='A'

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_SELECT] TO [db_sp_exec]
    AS [dbo];


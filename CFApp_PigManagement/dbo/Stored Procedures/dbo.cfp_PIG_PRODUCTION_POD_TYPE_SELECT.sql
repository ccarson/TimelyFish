-- ========================================================
-- Author:		Brian Cesafsky
-- Create date: 03/19/2009
-- Description:	Selects Pig Production Pod Types 
-- ========================================================
CREATE PROCEDURE [dbo].[cfp_PIG_PRODUCTION_POD_TYPE_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
		PodID
		,Description
	FROM 
		[$(SolomonApp)].dbo.cftPigProdPod (NOLOCK)	
	ORDER BY Description
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_PRODUCTION_POD_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];


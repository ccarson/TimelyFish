-- =============================================
-- Author:		Matt Brandt
-- Create date: 02/17/2011
-- Description:	This procedure produces the actual or recommended market loads for a given PigGroupID.
-- =============================================
CREATE PROCEDURE dbo.cfp_PIG_GROUP_CENSUS_PIG_FLOW_SELECT
      @PICYear_Week           CHAR(6)
,     @PigProdPhaseID         varchar(3)
,	@CurrentPICWeek char(6)


AS
BEGIN

SET NOCOUNT ON;

SELECT      -1, '--All--'PigFlowDescription
UNION ALL
SELECT      DISTINCT
      cft_PIG_GROUP_CENSUS.PigFlowID 
      ,cft_PIG_FLOW.PigFlowDescription
FROM cft_PIG_GROUP_CENSUS
LEFT JOIN [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW cft_PIG_FLOW (NOLOCK)
      ON cft_PIG_GROUP_CENSUS.PigFlowID = cft_PIG_FLOW.PigFlowID
WHERE PICYear_Week = @CurrentPICWeek
AND PigProdPhaseID like '%'
ORDER BY PigFlowDescription


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_CENSUS_PIG_FLOW_SELECT] TO [db_sp_exec]
    AS [dbo];




-- =============================================
-- Author:		Matt Brandt
-- Create date: 02/17/2011
-- Description:	This procedure produces the actual or recommended market loads for a given PigGroupID.
-- 2/22/2016, BMD, Updated to exclude SBF Pig Groups
-- =============================================
CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_CENSUS_ReportingGroup_SELECT]
      @PICYear_Week           CHAR(6)
,     @PigProdPhaseID         varchar(3)
,	@CurrentPICWeek char(6)


AS
BEGIN

SET NOCOUNT ON;

SELECT      -1, '--All--' Reporting_Group_Description
UNION ALL
SELECT      DISTINCT
      cft_PIG_GROUP_CENSUS.ReportingGroupID 
      ,rg.Reporting_Group_Description
FROM cft_PIG_GROUP_CENSUS
inner join [$(SolomonApp)].dbo.cftpiggroup cpp on cft_PIG_GROUP_CENSUS.PigGroupID=cpp.PigGroupID and cpp.PigProdPodID!= 53 -- Ignore SBF groups
LEFT JOIN [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW_REPORTING_GROUP rg (NOLOCK)
      ON cft_PIG_GROUP_CENSUS.reportinggroupID = rg.reportinggroupID
WHERE PICYear_Week = @CurrentPICWeek
  AND cft_PIG_GROUP_CENSUS.PigProdPhaseID like '%'
ORDER BY Reporting_Group_Description


END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_CENSUS_ReportingGroup_SELECT] TO [db_sp_exec]
    AS [dbo];


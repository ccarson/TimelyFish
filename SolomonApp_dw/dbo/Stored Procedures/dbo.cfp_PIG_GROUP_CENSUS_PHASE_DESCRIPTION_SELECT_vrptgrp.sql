

-- 2/22/2016, BMD, Updated to exclude SBF Pig Groups

CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_CENSUS_PHASE_DESCRIPTION_SELECT_vrptgrp]
	@PICYear_Week		CHAR(6)
,	@PigProdPhaseID		VARCHAR(3)
,	@ReportingGroupID			VARCHAR(10)
AS

IF @ReportingGroupID = '-1'
   SET @ReportingGroupID = '%'
	 
SELECT	'%', '--All--' PhaseDesc
UNION ALL
SELECT	DISTINCT
	cft_PIG_GROUP_CENSUS.PhaseDesc
	,cft_PIG_GROUP_CENSUS.PhaseDesc
FROM cft_PIG_GROUP_CENSUS
inner join [$(SolomonApp)].dbo.cftpiggroup cpp on cft_PIG_GROUP_CENSUS.PigGroupID=cpp.PigGroupID and cpp.PigProdPodID != 53 -- Ignore SBF groups
WHERE cft_PIG_GROUP_CENSUS.PICYear_Week = @PICYear_Week
AND cft_PIG_GROUP_CENSUS.PigProdPhaseID like @PigProdPhaseID
AND cft_PIG_GROUP_CENSUS.ReportingGroupID like @ReportingGroupID
ORDER BY PhaseDesc




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_CENSUS_PHASE_DESCRIPTION_SELECT_vrptgrp] TO [db_sp_exec]
    AS [dbo];


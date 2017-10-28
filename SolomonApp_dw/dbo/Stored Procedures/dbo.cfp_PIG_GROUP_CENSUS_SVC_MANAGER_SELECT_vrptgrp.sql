
-- 2/22/2016, BMD, Updated to exclude SBF Pig Groups

CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_CENSUS_SVC_MANAGER_SELECT_vrptgrp]
	@PICYear_Week		CHAR(6)
,	@PigProdPhaseID		VARCHAR(3)
,	@ReportingGroupID	VARCHAR(10)
,	@PhaseDesc			VARCHAR(30)
,	@SrSvcManager		VARCHAR(100)
AS

IF @ReportingGroupID = '-1'
   SET @ReportingGroupID = '%'
	 
SELECT	'%', '--All--' SvcManager
UNION ALL
SELECT	DISTINCT
	cft_PIG_GROUP_CENSUS.SvcManager
	,cft_PIG_GROUP_CENSUS.SvcManager
FROM cft_PIG_GROUP_CENSUS
inner join [$(SolomonApp)].dbo.cftpiggroup cpp on cft_PIG_GROUP_CENSUS.PigGroupID=cpp.PigGroupID and cpp.PigProdPodID!= 53 -- Ignore SBF groups
WHERE cft_PIG_GROUP_CENSUS.PICYear_Week = @PICYear_Week
AND cft_PIG_GROUP_CENSUS.PigProdPhaseID like @PigProdPhaseID
AND cft_PIG_GROUP_CENSUS.ReportingGroupID like @ReportingGroupID
AND cft_PIG_GROUP_CENSUS.PhaseDesc like @PhaseDesc
AND	RTRIM(cft_PIG_GROUP_CENSUS.SrSvcManager) LIKE RTRIM(@SrSvcManager)
ORDER BY SvcManager


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_CENSUS_SVC_MANAGER_SELECT_vrptgrp] TO [db_sp_exec]
    AS [dbo];



CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_CENSUS_SR_SVC_MANAGER_SELECT]
	@PICYear_Week		CHAR(6)
,	@PigProdPhaseID		VARCHAR(3)
,	@PigFlowID			VARCHAR(10)
,	@PhaseDesc			VARCHAR(30)
AS

IF @PigFlowID = '-1'
   SET @PigFlowID = '%'
	 
SELECT	'%', '--All--'SrSvcManager
UNION ALL
SELECT	DISTINCT
	cft_PIG_GROUP_CENSUS.SrSvcManager
	,cft_PIG_GROUP_CENSUS.SrSvcManager
FROM cft_PIG_GROUP_CENSUS
WHERE cft_PIG_GROUP_CENSUS.PICYear_Week = @PICYear_Week
AND cft_PIG_GROUP_CENSUS.PigProdPhaseID like @PigProdPhaseID
AND cft_PIG_GROUP_CENSUS.PigFlowID like @PigFlowID
AND cft_PIG_GROUP_CENSUS.PhaseDesc like @PhaseDesc
ORDER BY SrSvcManager


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_CENSUS_SR_SVC_MANAGER_SELECT] TO [db_sp_exec]
    AS [dbo];


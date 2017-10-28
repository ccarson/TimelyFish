

-- 2/22/2016, BMD, Updated to exclude SBF Pig Groups

CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_CENSUS_SITE_SELECT_vrptgrp]
	@PICYear_Week		CHAR(6)
,	@PigProdPhaseID		VARCHAR(3)
,	@ReportingGroupID			VARCHAR(10)
,	@PhaseDesc			VARCHAR(30)
,	@SrSvcManager		VARCHAR(100)
,	@SvcManager			VARCHAR(100)
AS

IF @ReportingGroupID = '-1'
   SET @ReportingGroupID = '%'
	 
SELECT	'%' SiteContactID, '--All--' ContactName
UNION ALL
SELECT	DISTINCT
	cft_PIG_GROUP_CENSUS.SiteContactID
	,Contact.ContactName
FROM cft_PIG_GROUP_CENSUS
inner join [$(SolomonApp)].dbo.cftpiggroup cpp on cft_PIG_GROUP_CENSUS.PigGroupID=cpp.PigGroupID and cpp.PigProdPodID!= 53 -- Ignore SBF groups
LEFT JOIN [$(CentralData)].dbo.Contact Contact (NOLOCK)
	ON CAST(cft_PIG_GROUP_CENSUS.SiteContactID AS INT) = Contact.ContactID
WHERE cft_PIG_GROUP_CENSUS.PICYear_Week = @PICYear_Week
AND cft_PIG_GROUP_CENSUS.PigProdPhaseID like @PigProdPhaseID
AND cft_PIG_GROUP_CENSUS.ReportingGroupID like @ReportingGroupID
AND cft_PIG_GROUP_CENSUS.PhaseDesc like @PhaseDesc
AND	RTRIM(cft_PIG_GROUP_CENSUS.SrSvcManager) LIKE RTRIM(@SrSvcManager)
AND	RTRIM(cft_PIG_GROUP_CENSUS.SvcManager) LIKE RTRIM(@SvcManager)
ORDER BY ContactName




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_CENSUS_SITE_SELECT_vrptgrp] TO [db_sp_exec]
    AS [dbo];


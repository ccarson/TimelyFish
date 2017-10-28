
CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_ROLLUP]
AS
BEGIN

-------------------------------------------------------------------------------------------------------
-- this is dependent on replication finishing, so should be run directly after log shipping completes
-------------------------------------------------------------------------------------------------------
--clear table for new data
truncate table  dbo.cft_PIG_GROUP_ROLLUP

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
INSERT INTO  dbo.cft_PIG_GROUP_ROLLUP
(	TaskID
,	SiteContactID
,	MasterGroup
,	ActCloseDate
,	ActStartDate
,	BarnNbr
,	Description
,	PodDescription
,	PGStatusID
,	PigGenderTypeID
,	Phase
,	PhaseDesc
,	SvcManager
,	SrSvcManager)
SELECT
	pg.TaskID,
	pg.SiteContactID,
	pg.CF03 MasterGroup,
	pg.ActCloseDate,
	pg.ActStartDate,
	RTRIM(ISNULL(pg.BarnNbr, '')) + ' ' +
	RTRIM(ISNULL(pgr.RoomNbr, '')) AS BarnNbr,
	pg.Description,
	ppp.Description,
	pg.PGStatusID,
	pg.PigGenderTypeID,
	PG.PigProdPhaseID,
	CASE WHEN PG.SingleStock <> 0 and FT.Description='WF'
		THEN 'SS WF '
	WHEN PG.SingleStock = 0 and FT.Description='WF' and PG.PigProdPhaseID='NUR'
		THEN 'WF '
	ELSE ''
	END + RTRIM(P.PhaseDesc) Phase,

	ISNULL(CASE WHEN pg.PGStatusID = 'I'
		THEN [$(SolomonApp)].dbo.GetSvcManagerNm(pg.SiteContactID, pg.ActCloseDate, '1/1/1900') 
		ELSE [$(SolomonApp)].dbo.GetSvcManagerNm(pg.SiteContactID, pg.EstCloseDate, '1/1/1900') 
	END, 'No Service Manager') AS PGServManager,

	ISNULL((SELECT TOP 1 Contact.ContactName
	FROM [$(CentralData)].dbo.ProdSvcMgrAssignment AS ProdSvcMgrAssignment WITH (NOLOCK)
	INNER JOIN [$(CentralData)].dbo.Contact AS Contact WITH (NOLOCK)
	ON Contact.ContactID = ProdSvcMgrAssignment.ProdSvcMgrContactID
	WHERE (ProdSvcMgrAssignment.SiteContactID = pg.SiteContactID)
	AND (ProdSvcMgrAssignment.EffectiveDate BETWEEN '1/1/1900' AND
	COALESCE (CASE WHEN pg.ActCloseDate = '1/1/1900' THEN NULL ELSE pg.ActCloseDate END, 
	CASE WHEN pg.EstCloseDate = '1/1/1900' THEN NULL ELSE pg.EstCloseDate END, GETDATE()))
	ORDER BY ProdSvcMgrAssignment.EffectiveDate DESC),
	'No Sr Svc Manager') AS PGSrServManager

FROM [$(SolomonApp)].dbo.cftPigGroup pg

LEFT OUTER JOIN [$(SolomonApp)].dbo.vCFPigGroupRoomFilter AS rf
	ON pg.PigGroupID = rf.PigGroupID AND rf.GroupCount = 1
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigGroupRoom AS pgr WITH (NOLOCK)
	ON rf.PigGroupID = pgr.PigGroupID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigProdPhase P WITH (NOLOCK)
	ON P.PigProdPhaseID = PG.PigProdPhaseID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftBarn B WITH (NOLOCK)
	ON B.ContactID=PG.SiteContactID and B.BarnNbr=PG.BarnNbr
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftFacilityType FT WITH (NOLOCK)
	ON FT.FacilityTypeID=B.FacilityTypeID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigProdPod ppp WITH (NOLOCK)
	ON ppp.PodID = PG.PigProdPodID
WHERE
pg.ActCloseDate>='12/28/2008'
AND pg.PGStatusID='I'
--AND pg.PigProdPhaseID in ('FIN','NUR')
AND PG.PigSystemID = '00'

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_ROLLUP] TO [db_sp_exec]
    AS [dbo];


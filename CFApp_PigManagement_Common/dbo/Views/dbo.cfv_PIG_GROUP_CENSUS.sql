
-- ==================================================================
-- Author:		mdawson
-- Create date: 1/6/2010
-- Description:	this gives current inventory and pig deaths by PIC week/pig group
-- ==================================================================
CREATE VIEW [dbo].[cfv_PIG_GROUP_CENSUS]
AS
SELECT
	ISNULL(CurrInv.PigGroupID, PigDeaths.PigGroupID) PigGroupID
,	ISNULL(CurrInv.PigProdPhaseID, PigDeaths.PigProdPhaseID) PigProdPhaseID
,	ISNULL(CurrInv.PhaseDesc, PigDeaths.PhaseDesc) PhaseDesc
,	ISNULL(CurrInv.SiteContactID, PigDeaths.SiteContactID) SiteContactID

,	ISNULL(CASE WHEN pg.PGStatusID = 'I'
		THEN [$(SolomonApp)].dbo.GetSvcManagerNm(pg.SiteContactID, pg.ActCloseDate, '1/1/1900') 
		ELSE [$(SolomonApp)].dbo.GetSvcManagerNm(pg.SiteContactID, pg.EstCloseDate, '1/1/1900') 
	END, 'No Service Manager') AS SvcManager
--Added SrSvcManager to requirements.  Completed 2/11/2010 John Maas---
,	ISNULL((SELECT TOP 1 Contact.ContactName
	FROM [$(CentralData)].dbo.ProdSvcMgrAssignment AS ProdSvcMgrAssignment WITH (NOLOCK)
	INNER JOIN [$(CentralData)].dbo.Contact AS Contact WITH (NOLOCK)
	ON Contact.ContactID = ProdSvcMgrAssignment.ProdSvcMgrContactID
	WHERE (ProdSvcMgrAssignment.SiteContactID = pg.SiteContactID)
	AND (ProdSvcMgrAssignment.EffectiveDate BETWEEN '1/1/1900' AND
	COALESCE (CASE WHEN pg.ActCloseDate = '1/1/1900' THEN NULL ELSE pg.ActCloseDate END, 
	CASE WHEN pg.EstCloseDate = '1/1/1900' THEN NULL ELSE pg.EstCloseDate END, GETDATE()))
	ORDER BY ProdSvcMgrAssignment.EffectiveDate DESC),
	'No Sr Svc Manager') AS SrServManager
,	ISNULL(CurrInv.Description, PigDeaths.Description) Description
,	ISNULL(CurrInv.PICYear_Week, PigDeaths.PICYear_Week) PICYear_Week
,	CurrInv.CurrentInv CurrentInv
,	PigDeaths.PigDeaths PigDeaths
FROM dbo.cfv_PIG_GROUP_CENSUS_CURRENT_INVENTORY CurrInv
FULL OUTER JOIN dbo.cfv_PIG_GROUP_CENSUS_PIG_DEATHS PigDeaths
	ON PigDeaths.PigGroupID = CurrInv.PigGroupID
	AND	PigDeaths.PICYear_Week = CurrInv.PICYear_Week
JOIN [$(SolomonApp)].dbo.cftPigGroup pg (NOLOCK)
	ON pg.PigGroupID = ISNULL(CurrInv.PigGroupID, PigDeaths.PigGroupID)

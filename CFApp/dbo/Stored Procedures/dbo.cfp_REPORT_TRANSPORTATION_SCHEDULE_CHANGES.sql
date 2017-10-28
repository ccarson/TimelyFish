

-- =============================================
-- Author:	Matt Dawson
-- Create date:	1/7/2008
-- Description:	Track changes made to the transportation schedule
-- Parameters: 	@StartDate, 
--		@EndDate
--
-- NOTES:	RecType = 1; Main Record
--		RecType = 2; History Record
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_TRANSPORTATION_SCHEDULE_CHANGES] 
@StartDate DATETIME,
@EndDate DATETIME
AS

SELECT DISTINCT
	1 'RecType'
,	cftPM.PMID
,	cftPM.PMLoadID
,	CAST(cftPM.ActualQty AS VARCHAR) 'ActualQty'
,	CAST(cftPM.ActualWgt AS VARCHAR) 'ActualWgt'
,	CAST(CONVERT(VARCHAR,cftPM.ArrivalDate,101) AS VARCHAR) 'ArrivalDate'
--,	CAST(CONVERT(VARCHAR,cftPM.ArrivalTime,114) AS VARCHAR) 'ArrivalTime'
,	SUBSTRING(CONVERT(CHAR(19),cftPM.ArrivalTime,100),13,19) 'ArrivalTime'
,	cftPM.Comment
,	cftPM.DestBarnNbr
,	DestContact.ShortName 'Destination'
,	CAST(cftPM.EstimatedQty AS VARCHAR) 'EstimatedQty'
,	cftPM.EstimatedWgt
--,	CAST(CONVERT(VARCHAR,cftPM.LoadingTime,114) AS VARCHAR) 'LoadingTime'
,	SUBSTRING(CONVERT(CHAR(19),cftPM.LoadingTime,100),13,19) 'LoadingTime'
,	CAST(CONVERT(VARCHAR,cftPM.MovementDate,101) AS VARCHAR) 'MovementDate'
,	cftPM.OrdNbr
,	cftPigTrailer.Description 'PigTrailer'
,	cftPigType.PigTypeDesc 'PigType'
,	PackerContact.ShortName 'Packer'
,	cftPM.PMTypeID
,	cftPM.SourceBarnNbr
,	SourceContact.ShortName 'Source'
,	CAST(cftPM.TrailerWashFlag AS VARCHAR) 'TrailerWashFlag'
,	cftPM.TranSubTypeID
,	TruckerContact.ShortName 'Trucker'
,	cftPM.Lupd_User 'CreatedBy'
,	'' 'CreatedDateTime'
,	0 'PMHistoryID'
,	'' 'SentChanges'
,	cftMarketSaleType.Description 'MarketType'
FROM	[$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact DestContact (NOLOCK)
	ON DestContact.ContactID = cftPM.DestContactID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact SourceContact (NOLOCK)
	ON SourceContact.ContactID = cftPM.SourceContactID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact TruckerContact (NOLOCK)
	ON TruckerContact.ContactID = cftPM.TruckerContactID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact PackerContact (NOLOCK)
	ON PackerContact.ContactID = cftPM.PkrContactID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftMarketSaleType cftMarketSaleType (NOLOCK)
	ON cftMarketSaleType.MarketSaleTypeID = cftPM.MarketSaleTypeID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigFlow cftPigFlow (NOLOCK)
	ON cftPigFlow.PigFlowID = cftPM.PigFlowID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigTrailer cftPigTrailer (NOLOCK) 
	ON CAST(cftPigTrailer.PigTrailerID AS INT) = CAST(cftPM.PigTrailerID AS INT)
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigGroup SourcePigGroup (NOLOCK)
	ON SourcePigGroup.PigGroupID = cftPM.SourcePigGroupID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigGroup DestPigGroup (NOLOCK)
	ON DestPigGroup.PigGroupID = cftPM.DestPigGroupID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigGenderType cftPigGenderType (NOLOCK)
	ON cftPigGenderType.PigGenderTypeID = cftPM.PigGenderTypeID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigType cftPigType (NOLOCK)
	ON cftPigType.PigTypeID = cftPM.PigTypeID
INNER JOIN dbo.cfv_PM_HISTORY_DETAILS History (NOLOCK)
	ON History.PMLoadID = cftPM.PMLoadID
	AND History.PMID = cftPM.PMID
WHERE	cftPM.MovementDate BETWEEN @StartDate AND @EndDate

UNION ALL
-- the following query unions in the changes...
SELECT	DISTINCT
	2 'RecType'
,	History.PMID
,	History.PMLoadID
,	History.ActualQty
,	History.ActualWgt
,	CAST(CONVERT(VARCHAR,History.ArrivalDate,101) AS VARCHAR) 'ArrivalDate'
,	SUBSTRING(CONVERT(CHAR(19),History.ArrivalTime,100),13,19) 'ArrivalTime'
,	History.Comment
,	History.DestBarnNbr
,	History.Destination
,	History.EstimatedQty
,	History.EstimatedWgt
,	SUBSTRING(CONVERT(CHAR(19),History.LoadingTime,100),13,19) 'LoadingTime'
,	CAST(CONVERT(VARCHAR,History.MovementDate,101) AS VARCHAR) 'MovementDate'
,	History.OrdNbr
,	History.PigTrailer
,	History.PigType
,	History.Packer
,	History.PMTypeID
,	History.SourceBarnNbr
,	History.Source
,	History.TrailerWashFlag
,	History.TranSubTypeID
,	History.Trucker
,	History.CreatedBy
,	CAST(CONVERT(VARCHAR,History.CreatedDateTime,100) AS VARCHAR) 'CreatedDateTime'
,	History.PMHistoryID
,	CASE WHEN (History.SentChanges) = 1 THEN 'S' ELSE '' END 'SentChanges'
,	History.MarketSaleType 'MarketType'
FROM	[$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact DestContact (NOLOCK)
	ON DestContact.ContactID = cftPM.DestContactID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact SourceContact (NOLOCK)
	ON SourceContact.ContactID = cftPM.SourceContactID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact TruckerContact (NOLOCK)
	ON TruckerContact.ContactID = cftPM.TruckerContactID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact PackerContact (NOLOCK)
	ON PackerContact.ContactID = cftPM.PkrContactID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftMarketSaleType cftMarketSaleType (NOLOCK)
	ON cftMarketSaleType.MarketSaleTypeID = cftPM.MarketSaleTypeID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigFlow cftPigFlow (NOLOCK)
	ON cftPigFlow.PigFlowID = cftPM.PigFlowID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigTrailer cftPigTrailer (NOLOCK) 
	ON CAST(cftPigTrailer.PigTrailerID AS INT) = CAST(cftPM.PigTrailerID AS INT)
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigGroup SourcePigGroup (NOLOCK)
	ON SourcePigGroup.PigGroupID = cftPM.SourcePigGroupID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigGroup DestPigGroup (NOLOCK)
	ON DestPigGroup.PigGroupID = cftPM.DestPigGroupID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigGenderType cftPigGenderType (NOLOCK)
	ON cftPigGenderType.PigGenderTypeID = cftPM.PigGenderTypeID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigType cftPigType (NOLOCK)
	ON cftPigType.PigTypeID = cftPM.PigTypeID
INNER JOIN dbo.cfv_PM_HISTORY_DETAILS History (NOLOCK)
	ON History.PMLoadID = cftPM.PMLoadID
	AND History.PMID = cftPM.PMID
WHERE	cftPM.MovementDate BETWEEN @StartDate AND @EndDate
ORDER BY cftPM.PMID, cftPM.PMLoadID, RecType, PMHistoryID DESC


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_SCHEDULE_CHANGES] TO [db_sp_exec]
    AS [dbo];


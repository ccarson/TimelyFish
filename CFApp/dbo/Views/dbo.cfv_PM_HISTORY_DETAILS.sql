
CREATE VIEW [dbo].[cfv_PM_HISTORY_DETAILS]
AS
SELECT
	cft_PM_History.PMHistoryID
,	cft_PM_History.ActualQty
,	cft_PM_HISTORY.ActualWgt
,	cft_PM_HISTORY.ArrivalDate
,	cft_PM_HISTORY.ArrivalTime
,	cft_PM_HISTORY.Comment
,	cft_PM_HISTORY.DestBarnNbr
,	DestContact.ShortName 'Destination'
,	DestPigGroup.Description 'DestPigGroup'
,	cft_PM_HISTORY.DestProject
,	cft_PM_HISTORY.DestRoomNbr
,	cft_PM_HISTORY.EstimatedQty
,	cft_PM_HISTORY.EstimatedWgt
,	cft_PM_HISTORY.ID
,	cft_PM_HISTORY.LoadingTime
,	cftMarketSaleType.Description 'MarketSaleType'
,	cft_PM_HISTORY.MovementDate
,	cft_PM_HISTORY.OrdNbr
,	cft_PM_HISTORY.OrigMovementDate
,	cft_PM_HISTORY.PFEUEligible
,	cftPigFlow.Description 'PigFlow'
,	cftPigGenderType.Description 'PigGender'
,	cftPigTrailer.Description 'PigTrailer'
,	cftPigType.PigTypeDesc 'PigType'
,	PackerContact.ShortName 'Packer'
,	cft_PM_HISTORY.PMID
,	cft_PM_HISTORY.PMLoadID
,	cft_PM_HISTORY.PMSystemID
,	cft_PM_HISTORY.PMTypeID
,	cft_PM_HISTORY.PoNbr
,	cft_PM_HISTORY.SourceBarnNbr
,	SourceContact.ShortName 'Source'
,	SourcePigGroup.Description 'SourcePigGroup'
,	cft_PM_HISTORY.SourceProject
,	cft_PM_HISTORY.SourceRoomNbr
,	cft_PM_HISTORY.TailBite
,	cft_PM_HISTORY.TattooFlag
,	cft_PM_HISTORY.TrailerWashFlag
,	cft_PM_HISTORY.TrailerWashStatus
,	cft_PM_HISTORY.TranSubTypeID
,	TruckerContact.ShortName 'Trucker'
,	cft_PM_HISTORY.CreatedBy
,	cft_PM_HISTORY.CreatedDateTime
,	cft_PM_HISTORY.SentChanges
FROM	dbo.cft_PM_HISTORY cft_PM_HISTORY (NOLOCK)
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact DestContact (NOLOCK)
	ON DestContact.ContactID = cft_PM_HISTORY.DestContactID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact SourceContact (NOLOCK)
	ON SourceContact.ContactID = cft_PM_HISTORY.SourceContactID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact TruckerContact (NOLOCK)
	ON TruckerContact.ContactID = cft_PM_HISTORY.TruckerContactID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact PackerContact (NOLOCK)
	ON PackerContact.ContactID = cft_PM_HISTORY.PkrContactID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftMarketSaleType cftMarketSaleType (NOLOCK)
	ON cftMarketSaleType.MarketSaleTypeID = cft_PM_HISTORY.MarketSaleTypeID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigFlow cftPigFlow (NOLOCK)
	ON cftPigFlow.PigFlowID = cft_PM_HISTORY.PigFlowID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigTrailer cftPigTrailer (NOLOCK) 
	ON cftPigTrailer.PigTrailerID = cft_PM_HISTORY.PigTrailerID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigGroup SourcePigGroup (NOLOCK)
	ON SourcePigGroup.PigGroupID = cft_PM_HISTORY.SourcePigGroupID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigGroup DestPigGroup (NOLOCK)
	ON DestPigGroup.PigGroupID = cft_PM_HISTORY.DestPigGroupID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigGenderType cftPigGenderType (NOLOCK)
	ON cftPigGenderType.PigGenderTypeID = cft_PM_HISTORY.PigGenderTypeID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigType cftPigType (NOLOCK)
	ON cftPigType.PigTypeID = cft_PM_HISTORY.PigTypeID




GO
GRANT SELECT
    ON OBJECT::[dbo].[cfv_PM_HISTORY_DETAILS] TO [db_sp_exec]
    AS [dbo];


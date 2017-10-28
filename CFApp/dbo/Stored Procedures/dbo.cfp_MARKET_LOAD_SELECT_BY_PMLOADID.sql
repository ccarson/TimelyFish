-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 03/07/2008
-- Description:	Returns all market movements (Tailender and Market Movements)
-- by a PMLoadID.
-- =============================================
CREATE PROCEDURE [dbo].[cfp_MARKET_LOAD_SELECT_BY_PMLOADID]
(
	@PigMovementLoadID bigint
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT pm.ActualQty ActualQuantity
		,pm.ActualWgt ActualWeight
		,pm.ArrivalDate
		,pm.ArrivalTime
		,pm.BoardBackColor
		,pm.Comment
		,pm.CpnyID CompanyID
		,pm.Crtd_DateTime CreatedDateTime
		,pm.Crtd_Prog CreatedProgram
		,pm.Crtd_User CreatedUser
		,pm.DeleteFlag
		,pm.DestBarnNbr DestinationBarnNumber
		,pm.DestContactID DestinationContactID
		,pm.DestPigGroupID DestinationPigGroupID
		,pm.DestProject DestinationProject 
		,pm.DestRoomNbr DestinationRoomNumber
		,pm.DestTask DestinationTask
		,pm.DestTestStatus DestinationTestStatus
		,pm.DisinfectFlg DisinfectFlag
		,pm.EstimatedQty EstimatedQuantity
		,pm.EstimatedWgt EstimatedWeight
		,pm.GiltAge
		,pm.Highlight
		,pm.ID MarketLoadID
		,pm.LineNbr LineNumber
		,pm.LoadingTime
		,pm.Lupd_DateTime LastUpdatedDateTime
		,pm.Lupd_Prog LastUpdatedProgram
		,pm.Lupd_User LastUpdatedUser
		,pm.MarketSaleTypeID
		,pm.MovementDate
		,pm.NonUSOrigin
		,pm.OrdNbr OrderNumber
		,pm.OrigMovementDate OriginalMovementDate
		,pm.PFEUEligible
		,pm.PigFlowID
		,pm.PigGenderTypeID
		,pm.PigTrailerID
		,pm.PigTypeID
		,pm.PkrContactID PackerContactID
		,pm.PMID PigMovementID
		,pm.PMLoadID PigMovementLoadId
		,pm.PMSystemID PigMovementSystemID
		,pm.PMTypeID PigMovementTypeID
		,pm.PONbr PoNumber
		,pm.SourceBarnNbr SourceBarnNumber
		,pm.SourceContactID 
		,pm.SourcePigGroupID 
		,pm.SourceProject
		,pm.SourceRoomNbr SourceRoomNumber
		,pm.SourceTask
		,pm.SourceTestStatus
		,pm.SuppressFlg SuppressFlag
		,pm.Tailbite
		,pm.TattooFlag
		,pm.TrailerWashFlag TrailerWashFlag
		,pm.TrailerWashStatus
		,pm.TranSubTypeID TransportTypeId
		,pm.TruckerContactID
		,pm.WalkThrough
		,cSource.ContactName Source
		,cDestination.ContactName Destination
		,pts.DestProdPhaseID DestinationProductionPhaseID
		,pts.SrcProdPhaseID SourceProductionPhaseID
		,ptt.Description TransportTypeDescription
		,Sourceppp.prodtype SourceProductionTypeID
		,Destppp.prodtype DestinationProductionTypeID
FROM 
	[$(SolomonApp)].dbo.cftPM pm (NOLOCK)
	left join [$(SolomonApp)].dbo.cftContact cSource (NOLOCK) on cSource.contactid = pm.SourceContactID
	left join [$(SolomonApp)].dbo.cftContact cDestination (NOLOCK) on cDestination.contactid = pm.DestContactID
	left join [$(SolomonApp)].dbo.cftpigtransys pts (NOLOCK) on pts.TranTypeID = pm.TranSubTypeID
	left join [$(SolomonApp)].dbo.cftPigTranType ptt (NOLOCK) on ptt.TranTypeID = pm.TranSubTypeID
	left join [$(SolomonApp)].dbo.cftPigProdPhase Sourceppp (NOLOCK) on Sourceppp.PigProdPhaseID = pts.SrcProdPhaseID
	left join [$(SolomonApp)].dbo.cftPigProdPhase Destppp (NOLOCK) on Destppp.PigProdPhaseID = pts.DestProdPhaseID
Where
	pm.PMLoadID = @PigMovementLoadID
	and
	(transubtypeid like '%M' or transubtypeid like '%T')
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_LOAD_SELECT_BY_PMLOADID] TO [db_sp_exec]
    AS [dbo];





-- =============================================
-- Author:		Dave Killion
-- Create date: 11/16/2007
-- Description:	Returns all market movements (Tailender and Market Movements)
-- for a specific date.
-- Update: Added "BioSecurityLevel" column - NHonetschlager 12/24/13
-- Update: Added "PackerDesc" column - NHonetschlager 01/21/15
-- =============================================
CREATE PROCEDURE [dbo].[cfp_MARKET_LOAD_SELECT_BY_DATE]
	-- Add the parameters for the stored procedure here
@MovementDate Datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
		distinct
		pm.ActualQty ActualQuantity
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
		--,Coalesce(pgs.Description, cSource.ContactName) Source
		,cDestination.ContactName Destination
		,pts.DestProdPhaseID DestinationProductionPhaseID
		,pts.SrcProdPhaseID SourceProductionPhaseID
		,ptt.Description TransportTypeDescription
		,Sourceppp.prodtype SourceProductionTypeID
		,Destppp.prodtype DestinationProductionTypeID
		,st.BioSecurityLevel																						--added 12/24/13 NJH
		,ord.Descr																									--added 01/21/15 NJH
		,REPLACE(STR(dc.TruckingCompanyContactID, 6), SPACE(1), '0') TruckingCompanyContactID						--added 08/18/15 DGD
FROM 
	[$(SolomonApp)].dbo.cftPM pm (NOLOCK)
	left join [$(SolomonApp)].dbo.cftContact cSource (NOLOCK) on cSource.contactid = pm.SourceContactID
	left join [$(SolomonApp)].dbo.cftContact cDestination (NOLOCK) on cDestination.contactid = pm.DestContactID
    --left join [$(SolomonApp)].dbo.cftPigGroup pgs on pgs.PigGroupID = pm.SourcePigGroupID
	--left join [$(SolomonApp)].dbo.cftPigGroup pgd on pgd.PigGroupID = pm.DestPigGroupID
	left join [$(SolomonApp)].dbo.cftpigtransys pts (NOLOCK) on pts.TranTypeID = pm.TranSubTypeID
	left join [$(SolomonApp)].dbo.cftPigTranType ptt (NOLOCK) on ptt.TranTypeID = pm.TranSubTypeID
	left join [$(SolomonApp)].dbo.cftPigProdPhase Sourceppp (NOLOCK) on Sourceppp.PigProdPhaseID = pts.SrcProdPhaseID
	left join [$(SolomonApp)].dbo.cftPigProdPhase Destppp (NOLOCK) on Destppp.PigProdPhaseID = pts.DestProdPhaseID
	left join [$(CentralData)].dbo.Site st (NOLOCK) on st.ContactID = pm.SourceContactID									--added 12/24/13 NJH
	left join [$(SolomonApp)].dbo.cftPSOrdHdr ord WITH (NOLOCK)ON pm.OrdNbr = ord.OrdNbr									--added 01/21/15 NJH
	left join [$(CentralData)].[dbo].[cfv_DriverCompany] dc (NOLOCK) on cast(pm.TruckerContactID as Integer) = dc.DriverContactID
Where
	MovementDate = @MovementDate
	and
	pm.PMTypeID <> '01'
	and
	(transubtypeid like '%M' 
		or transubtypeid like '%T' 
		or transubtypeid like '%C'
		or transubtypeid like '%E'
		or transubtypeid = 'WF')
Order By pm.SourceContactID
		 , pm.LoadingTime
END





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_LOAD_SELECT_BY_DATE] TO [db_sp_exec]
    AS [dbo];


-- =============================================
-- Author:		Dave Killion
-- Create date: 11/19/2007
-- Description:	Updates a record in the cftPM table
-- Used by the Market Movmenet Schedule screen
-- =============================================
CREATE PROCEDURE dbo.cfp_MARKET_LOAD_UPDATE
	-- Add the parameters for the stored procedure here
	@ActualQuantity int
	, @ActualWeight int
	, @ArrivalDate smalldatetime
	, @ArrivalTime smalldatetime
	, @BoardBackColor int
	, @Comment char(100)
	, @CompanyID char(10)
	, @CreatedDateTime smalldatetime
	, @CreatedProgram char(8)
	, @CreatedUser char(10)
	, @DeleteFlag int
	, @DestinationBarnNumber char(10)
	, @DestinationContactID char(10)
	, @DestinationPigGroupID char(10)
	, @DestinationProject char(16)
	, @DestinationRoomNumber char(10)
	, @DestinationTask char(32)
	, @DestinationTestStatus char(1)
	, @DisinfectFlag int
	, @EstimatedQuantity int
	, @EstimatedWeight char(7)
	, @GiltAge char(10)
	, @Highlight int
	, @LineNumber int
	, @LoadingTime smalldatetime
	, @LastUpdatedDateTime smalldatetime
	, @LastUpdatedProgram char(8)
	, @LastUpdatedUser char(10)
	, @MarketLoadID int
	, @MarketSaleTypeID char(2)
	, @MovementDate smalldatetime
	, @NonUSOrigin int
	, @OrderNumber char(10)
	, @OriginalMovementDate smalldatetime
	, @PFEUEligible int
	, @PigFlowID char(3)
	, @PigGenderTypeID char(6)
	, @PigTrailerID char(5)
	, @PigTypeID char(2)
	, @PackerContactID char(6)
	, @PigMovementID char(10)
	, @PigMovementLoadId char(10)
	, @PigMovementSystemID char(2)
	, @PigMovementTypeID char(2)
	, @PoNumber char(10)
	, @SourceBarnNumber char(10)
	, @SourceContactID char(10)
	, @SourcePigGroupID char(10)
	, @SourceProject char(16)
	, @SourceRoomNumber char(10)
	, @SourceTask char(32)
	, @SourceTestStatus char(1)
	, @SuppressFlag int
	, @Tailbite int 
	, @TattooFlag int 
	, @TrailerWashFlag int 
	, @TrailerWashStatus int
	, @TransportTypeId char(2)
	, @TruckerContactID char(6)
	, @WalkThrough int
AS
BEGIN

UPDATE [$(SolomonApp)].dbo.cftPM
   SET 
	  ActualQty = @ActualQuantity
      ,ActualWgt = @ActualWeight
      ,ArrivalDate = @ArrivalDate
      ,ArrivalTime = @ArrivalTime
      ,BoardBackColor = @BoardBackColor
      ,Comment = @Comment
      ,CpnyID = @CompanyID
      ,Crtd_DateTime = @CreatedDateTime
      ,Crtd_Prog = @CreatedProgram
      ,Crtd_User = @CreatedUser
      ,DeleteFlag = @DeleteFlag
      ,DestBarnNbr = @DestinationBarnNumber
      ,DestContactID = @DestinationContactID
      ,DestPigGroupID = @DestinationPigGroupID
      ,DestProject = @DestinationProject
      ,DestRoomNbr = @DestinationRoomNumber
      ,DestTask = @DestinationTask
      ,DestTestStatus = @DestinationTestStatus
      ,DisinfectFlg = @DisinfectFlag
      ,EstimatedQty = @EstimatedQuantity
      ,EstimatedWgt = @EstimatedWeight
      ,GiltAge = @GiltAge
      ,Highlight = @Highlight
      ,LineNbr = @LineNumber
      ,LoadingTime = @LoadingTime
      ,Lupd_DateTime = @LastUpdatedDateTime
      ,Lupd_Prog = @LastUpdatedProgram
      ,Lupd_User = @LastUpdatedUser
      ,MarketSaleTypeID = @MarketSaleTypeID
      ,MovementDate = @MovementDate
      ,NonUSOrigin = @NonUSOrigin
      ,OrdNbr = @OrderNumber
      ,OrigMovementDate = @OriginalMovementDate
      ,PFEUEligible = @PFEUEligible
      ,PigFlowID = @PigFlowID
      ,PigGenderTypeID = @PigGenderTypeID
      ,PigTrailerID = @PigTrailerID
      ,PigTypeID = @PigTypeID
      ,PkrContactID = @PackerContactID
      ,PMID = @PigMovementID
      ,PMLoadID = @PigMovementLoadId
      ,PMSystemID = @PigMovementSystemID
      ,PMTypeID = @PigMovementTypeID
      ,PONbr = @PoNumber
      ,SourceBarnNbr = @SourceBarnNumber
      ,SourceContactID = @SourceContactID
      ,SourcePigGroupID = @SourcePigGroupID
      ,SourceProject = @SourceProject
      ,SourceRoomNbr = @SourceRoomNumber
      ,SourceTask = @SourceTask
      ,SourceTestStatus = @SourceTestStatus
      ,SuppressFlg = @SuppressFlag
      ,Tailbite = @Tailbite
      ,TattooFlag = @TattooFlag
      ,TrailerWashFlag = @TrailerWashFlag
      ,TrailerWashStatus = @TrailerWashStatus
      ,TranSubTypeID = @TransportTypeId
      ,TruckerContactID = @TruckerContactID
      ,WalkThrough = @WalkThrough
where
	id = @MarketLoadID


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_LOAD_UPDATE] TO [db_sp_exec]
    AS [dbo];


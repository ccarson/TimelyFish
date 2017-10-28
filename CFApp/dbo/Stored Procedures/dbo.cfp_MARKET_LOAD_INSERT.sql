-- =============================================
-- Author:		Dave Killion
-- Create date: 11/19/2007
-- Description:	Updates a record in the cftPM table
-- Used by the Market Movmenet Schedule screen
-- =============================================
CREATE PROCEDURE [dbo].[cfp_MARKET_LOAD_INSERT]
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

INSERT [$(SolomonApp)].dbo.cftPM
			([ActualQty]
           ,[ActualWgt]
           ,[ArrivalDate]
           ,[ArrivalTime]
           ,[BoardBackColor]
           ,[Comment]
           ,[CpnyID]
           ,[Crtd_DateTime]
           ,[Crtd_Prog]
           ,[Crtd_User]
           ,[DeleteFlag]
           ,[DestBarnNbr]
           ,[DestContactID]
           ,[DestPigGroupID]
           ,[DestProject]
           ,[DestRoomNbr]
           ,[DestTask]
           ,[DestTestStatus]
           ,[DisinfectFlg]
           ,[EstimatedQty]
           ,[EstimatedWgt]
           ,[GiltAge]
           ,[Highlight]
           ,[LineNbr]
           ,[LoadingTime]
           ,[Lupd_DateTime]
           ,[Lupd_Prog]
           ,[Lupd_User]
           ,[MarketSaleTypeID]
           ,[MovementDate]
           ,[NonUSOrigin]
           ,[OrdNbr]
           ,[OrigMovementDate]
           ,[PFEUEligible]
           ,[PigFlowID]
           ,[PigGenderTypeID]
           ,[PigTrailerID]
           ,[PigTypeID]
           ,[PkrContactID]
		   ,PMID 
           ,PMLoadID 
           ,[PMSystemID]
           ,[PMTypeID]
           ,[PONbr]
           ,[SourceBarnNbr]
           ,[SourceContactID]
           ,[SourcePigGroupID]
           ,[SourceProject]
           ,[SourceRoomNbr]
           ,[SourceTask]
           ,[SourceTestStatus]
           ,[SuppressFlg]
           ,[Tailbite]
           ,[TattooFlag]
           ,[TrailerWashFlag]
           ,[TrailerWashStatus]
           ,[TranSubTypeID]
           ,[TruckerContactID]
           ,[WalkThrough])
values
			(@ActualQuantity
			,@ActualWeight
			,@ArrivalDate
			,@ArrivalTime
			,@BoardBackColor
			,@Comment
			,@CompanyID
			,@CreatedDateTime
			,@CreatedProgram
			,@CreatedUser
			,@DeleteFlag
			,@DestinationBarnNumber
			,@DestinationContactID
			,@DestinationPigGroupID
			,@DestinationProject
			,@DestinationRoomNumber
			,@DestinationTask
			,@DestinationTestStatus
			,@DisinfectFlag
			,@EstimatedQuantity
			,@EstimatedWeight
			,@GiltAge
			,@Highlight
			,@LineNumber
			,@LoadingTime
			,@LastUpdatedDateTime
			,@LastUpdatedProgram
			,@LastUpdatedUser
			,@MarketSaleTypeID
			,@MovementDate
			,@NonUSOrigin
			,@OrderNumber
			,@OriginalMovementDate
			,@PFEUEligible
			,@PigFlowID
			,@PigGenderTypeID
			,@PigTrailerID
			,@PigTypeID
			,@PackerContactID
			, @PigMovementID 
			, @PigMovementLoadId 
			,@PigMovementSystemID
			,@PigMovementTypeID
			,@PoNumber
			,@SourceBarnNumber
			,@SourceContactID
			,@SourcePigGroupID
			,@SourceProject
			,@SourceRoomNumber
			,@SourceTask
			,@SourceTestStatus
			,@SuppressFlag
			,@Tailbite
			,@TattooFlag
			,@TrailerWashFlag
			,@TrailerWashStatus
			,@TransportTypeId
			,@TruckerContactID
			,@WalkThrough)

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_LOAD_INSERT] TO [db_sp_exec]
    AS [dbo];


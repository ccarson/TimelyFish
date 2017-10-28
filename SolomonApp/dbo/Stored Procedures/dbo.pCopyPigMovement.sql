Create Procedure dbo.pCopyPigMovement
	@SpecificDate smalldatetime, @PigMovementID as int
AS
	Insert into PigMovement 
	(MovementDate,SourceContactID,SourceBarnID,SourceBarnNbr,DestinationContactID,
	 DestinationBarnID,DestinationBarnNbr,PigTypeID,GenderTypeID,PigGroupID,
         PigFlowTypeID,EstimatedQty,ActualQty,EstimatedWgt,ActualWgt,MovementTypeID,
         Comment,TruckerID,TrailerID,TrailerLocationID,TattooFlag,TrailerWashFlag,
         LoadingTime,ArrivalTime,Crtd_DateTime,Crtd_User,ArrivalDate,Highlight,
         BoardBackColor,BioSecurityFlag,MovementSystem,DeleteFlag,GiltAge,WalkThrough,
         SourceTestStatus,DestinationTestStatus,CompanyID)
	Select @SpecificDate,SourceContactID,SourceBarnID,SourceBarnNbr,DestinationContactID,
	 DestinationBarnID,DestinationBarnNbr,PigTypeID,GenderTypeID,PigGroupID,
         PigFlowTypeID,EstimatedQty,ActualQty,EstimatedWgt,ActualWgt,MovementTypeID,
         Comment,TruckerID,TrailerID,TrailerLocationID,TattooFlag,TrailerWashFlag,
         LoadingTime,ArrivalTime,Crtd_DateTime,Crtd_User,ArrivalDate,Highlight,
         BoardBackColor,BioSecurityFlag,MovementSystem,DeleteFlag,GiltAge,WalkThrough,
         SourceTestStatus,DestinationTestStatus,CompanyID from PigMovement where
	PigMovementID=@PigMovementID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCopyPigMovement] TO [MSDSL]
    AS [dbo];


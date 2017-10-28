Create Procedure dbo.pAddLivestockTransfer 
	@PigMovementID int, @PigMovementSubID int
	
	As
Insert into PigMovementLivestockTransfer (PigMovementID, PigMovementSubID,RecountRequired,SourceContactID, SourceBarnID,
	DestinationContactID, DestinationBarnID, GenderTypeID, SourceTransferStatus,DestinationTransferStatus)
Select @PigMovementID,@PigMovementSubID,0, SourceContactID,SourceBarnID, DestinationContactID, DestinationBarnID, GenderTypeID,0,0
	FROM PigMovement where PigMovementID=@PigMovementID


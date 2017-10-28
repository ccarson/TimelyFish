
Create Procedure dbo.pAddLoadQtys 
	@PigMovementID int, @PigMovementSubID int
	
	As
Insert into PigMovementLoadQty (PigMovementID,PigMovementSubID,Qty,LoadQtyTypeID)
Select @PigMovementID,@PigMovementSubID, 0, LoadQtyTypeID from LoadQtyType
where DefaultType=1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pAddLoadQtys] TO [MSDSL]
    AS [dbo];


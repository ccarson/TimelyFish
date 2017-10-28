--stored procedure used by Livestock Transfer Application
--retrieves a new PigMovementID for a non-transporation schedule load
CREATE PROC [dbo].[pGetNewPigMovementID] 
	@LoadID smallint OUTPUT
	As
	Select @LoadID=(Select Min(PigMovementID) 
	FROM PigMovement
	WHERE PigMovementID not in
	(Select PigMovementID from PigMovementLivestockTransfer)
	AND MovementSystem=3
	GROUP BY MovementSystem)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pGetNewPigMovementID] TO [MSDSL]
    AS [dbo];


--stored procedure used by Livestock Transfer Application
--retrieves the next PigMovementSubID for the specified load
CREATE PROC [dbo].[pGetPigMovementSubID] 
	@LoadID int,
	@SubLoadID smallint OUTPUT
	As
	Select @SubLoadID=((Select (Max(PigMovementSubID)+1) as nextSubID from PigMovementLivestockTransfer
	where PigMovementID=@LoadID))


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pGetPigMovementSubID] TO [MSDSL]
    AS [dbo];


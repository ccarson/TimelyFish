CREATE PROC [dbo].[pLoadCountCompare] 
	@LoadID int, @LoadSubID int,
	@Pass smallint OUTPUT
	As
	Select @Pass=(Select Count(Description) from vLivestockTransferLoadQty
	where PigMovementID=@LoadID and PigMovementSubID=@LoadSubID and MainQty<>BreakdownQty)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pLoadCountCompare] TO [MSDSL]
    AS [dbo];


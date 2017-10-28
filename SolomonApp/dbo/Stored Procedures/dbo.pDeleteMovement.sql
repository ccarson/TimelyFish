

CREATE PROC [dbo].[pDeleteMovement]
	@MovementID smallint
As

Delete from dbo.MarketMovement where MarketMovementID=@MovementID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pDeleteMovement] TO [MSDSL]
    AS [dbo];


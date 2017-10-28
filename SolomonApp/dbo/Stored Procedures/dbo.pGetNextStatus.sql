
CREATE PROC [dbo].[pGetNextStatus] 
	@CurrStatus smallint	
AS

	Select Min(MovementStatusID)
	FROM dbo.MovementStatus 
	Where MovementStatusID>@CurrStatus


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pGetNextStatus] TO [MSDSL]
    AS [dbo];


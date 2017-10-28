CREATE Proc dbo.pPigFlowBoardSpecificDay
	@SpecDate smalldatetime
	As
	SELECT *
	
	FROM dbo.PigMovement pm

	Where MovementDate = @SpecDate
	Order by PigMovementID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pPigFlowBoardSpecificDay] TO [MSDSL]
    AS [dbo];


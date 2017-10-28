
CREATE PROC [dbo].[pMarketMovementStatus] 
	@BegDate smalldatetime,
	@MovementStatus int OUTPUT,
	@NextStatus int OUTPUT

	As

	Declare @EndDate smalldatetime
	
	Select @EndDate = @BegDate + 6

	Select @MovementStatus=Max(MovementStatusID) 
	from dbo.MarketMovement
	where MovementDate between @BegDate and @EndDate

	if @MovementStatus is null 
	begin
	Select @NextStatus =Min(MovementStatusID)
	from dbo.MovementStatus 
	where MovementStatusID>10
	end

	if @MovementStatus is not null 
	begin
	Select @NextStatus =Min(MovementStatusID)
	from dbo.MovementStatus 
	where MovementStatusID>@MovementStatus
	end



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pMarketMovementStatus] TO [MSDSL]
    AS [dbo];


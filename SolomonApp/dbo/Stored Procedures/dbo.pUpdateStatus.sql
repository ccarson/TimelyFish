CREATE PROC [dbo].[pUpdateStatus] 
	@NextStatus smallint,
	@BegDate smalldatetime	

AS

DECLARE @EndDate smalldatetime

	Select @EndDate=@BegDate+6
	
UPDATE    dbo.MarketMovement
SET       MovementStatusID = @NextStatus
WHERE MovementDate between @BegDate and @EndDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pUpdateStatus] TO [MSDSL]
    AS [dbo];


CREATE PROC [dbo].[pServiceMarketMovementWeek] 
	@BegDate smalldatetime,
	@ServiceManager varchar(20)

	As

	Declare @EndDate smalldatetime

	Select @EndDate=@BegDate+6

	Select *
	from dbo.vMarketMovementFilter mm
	WHERE (Crtd_User=@ServiceManager or mm.ServiceManager=@ServiceManager or mm.MarketManager=@ServiceManager)
		 and (mm.movementdate between @BegDate and @EndDate)
	


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pServiceMarketMovementWeek] TO [MSDSL]
    AS [dbo];


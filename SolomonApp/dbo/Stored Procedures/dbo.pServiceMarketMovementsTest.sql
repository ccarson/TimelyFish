CREATE PROC [dbo].[pServiceMarketMovementsTest] 
	@CurrDate smalldatetime,
	@ServiceManager varchar(20)

	As
	Select *

	from dbo.vMarketMovementFilter mm
	WHERE (Crtd_User=@ServiceManager or mm.ServiceManager=@ServiceManager or mm.MarketManager=@ServiceManager)
	 and (mm.movementdate =@CurrDate) 
	
ORDER BY MarketMovementID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pServiceMarketMovementsTest] TO [MSDSL]
    AS [dbo];


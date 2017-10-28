CREATE PROC [dbo].[pServiceMarketMovementsASP] 
	@CurrDate smalldatetime,
	@ServiceManager varchar(20)

	As
	Select *

	from dbo.vMarketMovement mm
	WHERE (Crtd_User=@ServiceManager or mm.ServiceManager=@ServiceManager or mm.MarketManager=@ServiceManager)
	 and (mm.movementdate =@CurrDate) 
	
ORDER BY MarketMovementID




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pServiceMarketMovementsASP] TO [MSDSL]
    AS [dbo];


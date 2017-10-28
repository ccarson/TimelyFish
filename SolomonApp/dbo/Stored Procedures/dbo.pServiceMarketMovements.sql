CREATE PROC [dbo].[pServiceMarketMovements] 
	@CurrDate smalldatetime,
	@ServiceManager varchar(20),
	@Company as varchar(3)

	As
	IF @Company='CFM'
		BEGIN
		Select *

		from dbo.vMarketMovement mm
		WHERE (Crtd_User=@ServiceManager or mm.ServiceManager=@ServiceManager or mm.MarketManager=@ServiceManager)
	 	and (mm.movementdate =@CurrDate and Lupd_User=@Company) 
		ORDER BY MarketMovementID
		END	
	ELSE
		BEGIN
		Select *

		from dbo.vMarketMovement mm
		WHERE (Crtd_User=@ServiceManager or mm.ServiceManager=@ServiceManager or mm.MarketManager=@ServiceManager)
		 and (mm.movementdate =@CurrDate and isnull(Lupd_User,0)<>'CFM')
		ORDER BY MarketMovementID 
	END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pServiceMarketMovements] TO [MSDSL]
    AS [dbo];


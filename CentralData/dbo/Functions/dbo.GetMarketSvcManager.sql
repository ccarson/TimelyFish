CREATE FUNCTION [dbo].[GetMarketSvcManager] 
     (@SiteContactID as int, @EndDate as smalldatetime,@StartDate as smalldatetime='1/1/1901')  
RETURNS varchar(20)
AS
	BEGIN 
	DECLARE @pcharReturn varchar(20)
	SET @pcharReturn=(SELECT e.UserID
			FROM MarketSvcMgrAssignment sma
			JOIN  dbo.Employee e on sma.MarketSvcMgrContactID=e.ContactID
			WHERE sma.SiteContactID = @SiteContactID AND sma.EffectiveDate = 
			( SELECT MAX(EffectiveDate) 
				FROM MarketSvcMgrAssignment 
				WHERE SiteContactID = @SiteContactID AND EffectiveDate Between @StartDate and @EndDate ) )


	 RETURN @pcharReturn
	END

CREATE FUNCTION [dbo].[GetSvcManager] 
     (@SiteContactID as int, @EndDate as smalldatetime,@StartDate as smalldatetime='1/1/1901')  
RETURNS varchar(20)
AS
	BEGIN 
	DECLARE @pcharReturn varchar(20)
	SET @pcharReturn=(SELECT e.UserID
			FROM SiteSvcMgrAssignment sma
			JOIN  dbo.Employee e on sma.SvcMgrContactID=e.ContactID
			WHERE sma.SiteContactID = @SiteContactID AND sma.EffectiveDate = 
			( SELECT MAX(EffectiveDate) 
				FROM SiteSvcMgrAssignment 
				WHERE SiteContactID = @SiteContactID AND EffectiveDate Between @StartDate and @EndDate ) )


	 RETURN @pcharReturn
	END

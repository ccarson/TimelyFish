CREATE FUNCTION [dbo].[GetSvcManagerID] 
     (@SiteContactID as int, @EndDate as smalldatetime,@StartDate as smalldatetime='1/1/1901')  
RETURNS int
AS
	BEGIN 
	DECLARE @pintReturn int
	SET @pintReturn=(SELECT e.ContactID
			FROM SiteSvcMgrAssignment sma
			JOIN  dbo.Employee e on sma.SvcMgrContactID=e.ContactID
			WHERE sma.SiteContactID = @SiteContactID AND sma.EffectiveDate = 
			( SELECT MAX(EffectiveDate) 
				FROM SiteSvcMgrAssignment 
				WHERE SiteContactID = @SiteContactID AND EffectiveDate Between @StartDate and @EndDate ) )


	 RETURN @pintReturn
	END

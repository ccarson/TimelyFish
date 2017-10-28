
CREATE FUNCTION [dbo].[GetSvcManagerID] 
     (@SiteContactID as varchar(6), @EndDate as smalldatetime,@StartDate as smalldatetime='1/1/1901')  
RETURNS int
AS
	BEGIN 
	DECLARE @pintReturn int
	SET @pintReturn=(SELECT e.ContactID
			FROM cftSiteSvcMgrAsn sma
			JOIN cftEmployee e on sma.SvcMgrContactID=e.ContactID
			WHERE sma.SiteContactID = @SiteContactID AND sma.EffectiveDate = 
			( SELECT MAX(EffectiveDate) 
				FROM cftSiteSvcMgrAsn 
				WHERE SiteContactID = @SiteContactID AND EffectiveDate Between @StartDate and @EndDate ) )


	 RETURN @pintReturn
	END


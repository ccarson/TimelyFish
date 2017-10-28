
CREATE FUNCTION [dbo].[GetSvcManager] 
     (@SiteContactID as varchar(6), @EndDate as smalldatetime,@StartDate as smalldatetime='1/1/1901')  
RETURNS varchar(20)
AS
	BEGIN 
	DECLARE @pcharReturn varchar(20)
	SET @pcharReturn=(SELECT e.UserID
			FROM cftSiteSvcMgrAsn sma
			JOIN cftEmployee e on sma.SvcMgrContactID=e.ContactID
			WHERE sma.SiteContactID = @SiteContactID AND sma.EffectiveDate = 
			( SELECT MAX(EffectiveDate) 
				FROM cftSiteSvcMgrAsn 
				WHERE SiteContactID = @SiteContactID AND EffectiveDate Between @StartDate and @EndDate ) )


	 RETURN @pcharReturn
	END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetSvcManager] TO [MSDSL]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSvcManager] TO [MSDSL]
    AS [dbo];


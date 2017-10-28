CREATE  FUNCTION [dbo].[GetSvcManagerNm] 
     (@SiteContactID as varchar(6), @EndDate as smalldatetime,@StartDate as smalldatetime='1/1/1901')  
RETURNS varchar(20)
AS
	BEGIN 
	DECLARE @pcharReturn varchar(20)
	SET @pcharReturn=(SELECT ct.ContactName
			FROM dbo.cftSiteSvcMgrAsn sma
			JOIN dbo.cftContact ct on sma.SvcMgrContactID=ct.ContactID
			WHERE sma.SiteContactID = @SiteContactID AND sma.EffectiveDate = 
			( SELECT MAX(EffectiveDate) 
				FROM dbo.cftSiteSvcMgrAsn 
				WHERE SiteContactID = @SiteContactID AND EffectiveDate Between @StartDate and @EndDate ) )
	 RETURN @pcharReturn
	END


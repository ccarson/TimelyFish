

CREATE FUNCTION [dbo].[GetMarketSvcManagerID] 
     (@SiteContactID as int, @EndDate as smalldatetime,@StartDate as smalldatetime='1/1/1901')  
RETURNS varchar(20)
AS
	BEGIN 
	DECLARE @pintReturn int
	SET @pintReturn=(SELECT e.ContactID
			FROM cftMktMgrAssign sma
			JOIN cftEmployee e on sma.MktMgrContactID=e.ContactID
			WHERE sma.SiteContactID = @SiteContactID AND sma.EffectiveDate = 
			( SELECT MAX(EffectiveDate) 
				FROM cftMktMgrAssign 
				WHERE SiteContactID = @SiteContactID AND EffectiveDate Between @StartDate and @EndDate ) )


	 RETURN @pintReturn
	END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetMarketSvcManagerID] TO [MSDSL]
    AS [dbo];


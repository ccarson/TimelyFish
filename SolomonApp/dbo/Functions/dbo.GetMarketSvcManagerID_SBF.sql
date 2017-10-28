
-- =============================================
-- Author:	Doran Dahle
-- Create date:	2/1/2016
-- Description:	Finds the Service\Market Manager for a site created for the SBF sale
-- =============================================

CREATE FUNCTION [dbo].[GetMarketSvcManagerID_SBF] 
     (@SiteContactID as int, @EndDate as smalldatetime,@StartDate as smalldatetime='1/1/1901')  
RETURNS int
AS
	BEGIN 
	DECLARE @pintReturn int
	SET @pintReturn=(SELECT sma.MktMgrContactID
			FROM cftMktMgrAssign sma
			WHERE sma.SiteContactID = @SiteContactID AND sma.EffectiveDate = 
			( SELECT MAX(EffectiveDate) 
				FROM cftMktMgrAssign 
				WHERE SiteContactID = @SiteContactID AND EffectiveDate Between @StartDate and @EndDate ) )
	 RETURN @pintReturn
	END





GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetMarketSvcManagerID_SBF] TO [MSDSL]
    AS [dbo];


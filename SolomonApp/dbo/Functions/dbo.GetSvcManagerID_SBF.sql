

-- =============================================
-- Author:	Doran Dahle
-- Create date:	2/1/2016
-- Description:	Finds the Service\Market Manager for a site created for the SBF sale
-- =============================================


CREATE FUNCTION [dbo].[GetSvcManagerID_SBF] 
     (@SiteContactID as varchar(6), @EndDate as smalldatetime,@StartDate as smalldatetime='1/1/1901')  
RETURNS int
AS
	BEGIN 
	DECLARE @pintReturn int
	SET @pintReturn=(SELECT sma.SvcMgrContactID
			FROM cftSiteSvcMgrAsn sma
			WHERE sma.SiteContactID = @SiteContactID AND sma.EffectiveDate = 
			( SELECT MAX(EffectiveDate) 
				FROM cftSiteSvcMgrAsn 
				WHERE SiteContactID = @SiteContactID AND EffectiveDate Between @StartDate and @EndDate ) )

	 RETURN @pintReturn
	END





GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetSvcManagerID_SBF] TO [MSDSL]
    AS [dbo];


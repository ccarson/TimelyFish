


-- =============================================
-- Author:	Brian Diehl
-- Created:	2/5/2016
-- Description:	Finds the Senior Service Manager for a site
-- =============================================


CREATE FUNCTION [dbo].[GetSeniorSvcManagerID] 
     (@SiteContactID as varchar(6), @EndDate as smalldatetime,@StartDate as smalldatetime='1/1/1901')  
RETURNS int
AS
	BEGIN 
	DECLARE @pintReturn int
	SET @pintReturn=(SELECT sma.[ProdSvcMgrContactID]
			FROM [CentralData].[dbo].[ProdSvcMgrAssignment] sma
			WHERE sma.SiteContactID = @SiteContactID AND sma.EffectiveDate = 
			( SELECT MAX(EffectiveDate) 
				FROM [CentralData].[dbo].[ProdSvcMgrAssignment] 
				WHERE SiteContactID = @SiteContactID AND EffectiveDate Between @StartDate and @EndDate ) )

	 RETURN @pintReturn
	END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetSeniorSvcManagerID] TO [MSDSL]
    AS [dbo];


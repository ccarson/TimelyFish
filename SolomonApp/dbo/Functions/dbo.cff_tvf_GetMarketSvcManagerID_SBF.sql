CREATE FUNCTION 
	dbo.cff_tvf_GetMarketSvcManagerID_SBF( 
		@SiteContactID 	int
	  , @EffectiveDate 	smalldatetime ) 
RETURNS TABLE 
AS

RETURN 

SELECT TOP 1 
	MarketServiceManagerID = MktMgrContactID
FROM 
	dbo.cftMktMgrAssign
WHERE 
	SiteContactID = @SiteContactID 
		AND CONVERT( smalldatetime, ( CONVERT( date, @EffectiveDate ) ) ) !> EffectiveDate 
ORDER BY EffectiveDate Desc ; 
CREATE FUNCTION 
	dbo.cff_tvf_GetSvcManagerID_SBF( 
		@SiteContactID 	int
	  , @EffectiveDate 	smalldatetime ) 

RETURNS TABLE 
AS

RETURN 

SELECT TOP 1 
	SvcManagerContactID = SvcMgrContactID
FROM 
	dbo.cftSiteSvcMgrAsn
WHERE 
	SiteContactID = @SiteContactID 
		AND CONVERT( smalldatetime, ( CONVERT( date, @EffectiveDate ) ) ) !> EffectiveDate 

ORDER BY EffectiveDate Desc ; 
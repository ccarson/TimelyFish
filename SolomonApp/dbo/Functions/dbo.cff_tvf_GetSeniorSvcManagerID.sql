CREATE FUNCTION 
	dbo.cff_tvf_GetSeniorSvcManagerID( 
		@SiteContactID 	int
	  , @EffectiveDate 	smalldatetime ) 

RETURNS TABLE 
AS

RETURN 

SELECT TOP 1 
	SeniorSvcManagerID = ProdSvcMgrContactID
FROM 
	dbo.cftProdSvcMgr
WHERE 
	SiteContactID = @SiteContactID 
		AND CONVERT( smalldatetime, ( CONVERT( date, @EffectiveDate ) ) ) !> EffectiveDate 

ORDER BY EffectiveDate Desc ; 
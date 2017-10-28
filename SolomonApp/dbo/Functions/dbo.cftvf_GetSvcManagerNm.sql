
CREATE FUNCTION 
	dbo.cftvf_GetSvcManagerNm (
		@pSiteContactID	VARCHAR(6)
	  , @pEndDate		SMALLDATETIME ) 
RETURNS TABLE 
AS

RETURN

SELECT TOP 1 
	ServiceManagerName = ct.ContactName
FROM
	dbo.cftContact AS ct 
INNER JOIN
	dbo.cftSiteSvcMgrAsn AS sma
		ON sma.SvcMgrContactID = ct.ContactID
WHERE 
	sma.SiteContactID = @pSiteContactID 
		AND	sma.EffectiveDate !> @pEndDate
ORDER BY
	EffectiveDate DESC


GO
GRANT CONTROL
    ON OBJECT::[dbo].[cftvf_GetSvcManagerNm] TO [MSDSL]
    AS [dbo];


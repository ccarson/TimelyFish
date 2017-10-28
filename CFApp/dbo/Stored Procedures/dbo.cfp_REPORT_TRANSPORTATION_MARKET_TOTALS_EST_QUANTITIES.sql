

-- =============================================
-- Author:	Matt Dawson
-- Create date:	1/13/2008
-- Description:	Show quantities in a week going to market
-- Parameters: 	@StartDate
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_TRANSPORTATION_MARKET_TOTALS_EST_QUANTITIES] 
@StartDate DATETIME
AS

SELECT
	RTRIM(cftContact.ShortName) 'Packer'
,	cftPM.MovementDate
,	SUM(cftPM.EstimatedQty) 'EstimatedQty'
FROM	[$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
LEFT OUTER JOIN	[$(SolomonApp)].dbo.cftPacker cftPacker (NOLOCK)
	ON	cftPacker.ContactID = cftPM.DestContactID
LEFT OUTER JOIN	[$(SolomonApp)].dbo.cftContact cftContact (NOLOCK)
	ON	cftContact.ContactID = cftPacker.ContactID
WHERE	MovementDate BETWEEN @StartDate AND DATEADD(DAY, 6, @StartDate)
and cftPM.Highlight <> 255
and cftPM.Highlight <> -65536
GROUP BY
	RTRIM(cftContact.ShortName)
,	cftPM.MovementDate
ORDER BY
	cftPM.MovementDate
,	RTRIM(cftContact.ShortName)


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_MARKET_TOTALS_EST_QUANTITIES] TO [db_sp_exec]
    AS [dbo];


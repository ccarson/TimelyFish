


-- =============================================
-- Author:	Matt Dawson
-- Create date:	12/28/2007
-- Description:	Shows any activity for site selected within +/- 30 days of date selected
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_TRANSPORTATION_SITE_REPORT] 
@ContactID int,
@ReportDate DATETIME
AS

DECLARE @StartDate DATETIME
DECLARE @EndDATE DATETIME
DECLARE @ContactName CHAR(50)
SET @StartDate = DATEADD(day,-30,@ReportDate)
SET @EndDate = DATEADD(day,30,@ReportDate)
SET @ContactName = (SELECT RTRIM(ContactName) FROM [$(SolomonApp)].dbo.cftContact WITH (NOLOCK) WHERE cast(ContactID as int) = @ContactID)

SELECT
	rtrim(cftPM.PMLoadID) 'Load Number',
	rtrim(SourceContact.ContactName) 'Source',
	rtrim(cftPM.SourceBarnNbr) 'Source Barn',
	rtrim(DestinationContact.ContactName) 'Destination',
	rtrim(cftPM.DestBarnNbr) 'Destination Barn',
	convert(varchar,cftPM.MovementDate,101) 'MovementDate',
	convert(varchar,cftPM.LoadingTime,108) 'LoadingTime',
	convert(varchar,cftPM.ArrivalDate,101) 'ArrivalDate',
	convert(varchar,cftPM.ArrivalTime,108) 'ArrivalTime',
	cftPM.EstimatedQty,
	rtrim(cftPM.EstimatedWgt) 'EstimatedWgt',
	cftPM.ActualQty,
	cftPM.ActualWgt,
	cftMarketSaleType.Description 'Market Type',
	@ContactName 'SiteReported'
FROM [$(SolomonApp)].dbo.cftPM cftPM WITH (NOLOCK)
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact SourceContact WITH (NOLOCK)
	ON cast(SourceContact.ContactID as int) = cast(cftPM.SourceContactID as int)
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact DestinationContact WITH (NOLOCK)
	ON cast(DestinationContact.ContactID as int) = cast(cftPM.DestContactID as int)
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftMarketSaleType cftMarketSaleType WITH (NOLOCK)
	ON cftMarketSaleType.MarketSaleTypeID = cftPM.MarketSaleTypeID
WHERE cftPM.ArrivalDate BETWEEN @StartDate AND @EndDate
AND (cast(cftPM.DestContactID as int) = @ContactID or cast(cftPM.SourceContactID as int) = @ContactID)
ORDER BY cftPM.PMLoadID




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_SITE_REPORT] TO [db_sp_exec]
    AS [dbo];


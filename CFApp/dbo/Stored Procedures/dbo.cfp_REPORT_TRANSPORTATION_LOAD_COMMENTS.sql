
-- =============================================
-- Author:	Matt Dawson
-- Create date:	11/27/2007
-- Description:	Source for Comments report for Transportation Loads
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_TRANSPORTATION_LOAD_COMMENTS] 
@StartDate DATETIME,
@EndDate DATETIME,
@PMTypeID CHAR(2)
AS
DECLARE @PMFilter VARCHAR(2)
IF (@PMTypeID = 'Al')
BEGIN
	SET @PMFilter = '%'
END
ELSE
BEGIN
	SET @PMFilter = @PMTypeID
END
SELECT
	cftPM.PMLoadID 'Load Number',
	SourceContact.ContactName 'Source',
	DestinationContact.ContactName 'Destination',
	CONVERT(VARCHAR,cftPM.MovementDate,101) 'MovementDate',
	cftPM.EstimatedQty,
	cftPM.EstimatedWgt,
	cftMarketSaleType.Description 'Market Type',
	cftPM.Comment
FROM [$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact SourceContact (NOLOCK)
	ON SourceContact.ContactID = cftPM.SourceContactID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact DestinationContact (NOLOCK)
	ON DestinationContact.ContactID = cftPM.DestContactID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftMarketSaleType cftMarketSaleType (NOLOCK)
	ON cftMarketSaleType.MarketSaleTypeID = cftPM.MarketSaleTypeID
WHERE cftPM.Comment IS NOT NULL
AND RTRIM(cftPM.Comment) <> ''
AND cftPM.ArrivalDate BETWEEN @StartDate AND @EndDate
AND cftPM.PMTypeID LIKE @PMFilter
ORDER BY cftPM.PMLoadID


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_LOAD_COMMENTS] TO [db_sp_exec]
    AS [dbo];


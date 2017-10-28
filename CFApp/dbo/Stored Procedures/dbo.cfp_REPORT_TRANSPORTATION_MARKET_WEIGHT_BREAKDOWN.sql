

-- =============================================
-- Author:	Matt Dawson
-- Create date:	1/13/2008
-- Description:	Shows weight breakdowns by packer for date range
-- Parameters: 	@StartDate, @EndDate
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_TRANSPORTATION_MARKET_WEIGHT_BREAKDOWN] 
@StartDate DATETIME,
@EndDate DATETIME
AS


SELECT 
	cftPM.CpnyID, 
	SUM(CASE WHEN cftPM.EstimatedWgt >= 290 THEN CAST(cftPM.EstimatedQty AS INT) END) '290', 
	SUM(CASE WHEN (cftPM.EstimatedWgt >= 275 and cftPM.EstimatedWgt < 290) THEN CAST(cftPM.EstimatedQty AS INT) END) '289-275', 
	SUM(CASE WHEN (cftPM.EstimatedWgt >= 260 and cftPM.EstimatedWgt < 275) THEN CAST(cftPM.EstimatedQty AS INT) END) '274-260', 
	SUM(CASE WHEN cftPM.EstimatedWgt < 260 THEN CAST(cftPM.EstimatedQty AS INT) END) '260', 
	DestContact.ShortName
--	cftMarketSaleType.MarketTotalType
FROM	[$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
INNER JOIN [$(SolomonApp)].dbo.cftMarketSaleType cftMarketSaleType (NOLOCK)
	ON cftPM.MarketSaleTypeID=cftMarketSaleType.MarketSaleTypeID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact DestContact (NOLOCK)
	ON DestContact.ContactID = cftPM.DestContactID
INNER JOIN [$(SolomonApp)].dbo.cftPacker cftPacker (NOLOCK)
	ON DestContact.ContactID = cftPacker.ContactID
WHERE	cftPM.PMTypeID = '02' 
AND	cftPM.MovementDate BETWEEN @StartDate AND @EndDate
AND	cftPM.SuppressFlg = 0 
AND	cftPM.Highlight <> 255 
AND	cftPM.Highlight <> -65536
AND	cftMarketSaleType.MarketTotalType <> 'NON'
GROUP BY cftPM.CpnyID, DestContact.ShortName
ORDER BY cftPM.CpnyID, DestContact.ShortName


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_MARKET_WEIGHT_BREAKDOWN] TO [db_sp_exec]
    AS [dbo];


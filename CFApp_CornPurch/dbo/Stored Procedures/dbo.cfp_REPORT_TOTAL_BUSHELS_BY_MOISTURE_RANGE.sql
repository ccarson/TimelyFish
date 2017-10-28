
-- =============================================
-- Author:		Matt Dawson
-- Create date: 08/25/2008
-- Description:	Returns Moisture and Bushel information on tickets within
--	date range & moisture range for Feed Mill
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_TOTAL_BUSHELS_BY_MOISTURE_RANGE]
(	@StartDate DATETIME
,	@EndDate DATETIME
,	@StartRange DECIMAL(4,1)
,	@EndRange DECIMAL(4,1)
,	@FeedMillID CHAR(10)
,	@CommodityID varchar(50)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

IF @CommodityID = '0'
	SET @CommodityID = '%'

SELECT
	cft_FEED_MILL.Name 'FeedMill'
,	cft_CORN_TICKET.DestinationFarmBin 'BinName'
,	CONVERT(VARCHAR,cft_CORN_TICKET.DeliveryDate,101) 'DeliveryDate'
,	CAST(SUM(COALESCE(cft_Partial_Ticket.WetBushels,0)) AS NUMERIC(18,4)) 'SumWetBushels'
,	CASE WHEN @CommodityID = '%' THEN 'All Commodities' ELSE cft_COMMODITY.Description END 'Commodity'
FROM		dbo.cft_CORN_TICKET cft_CORN_TICKET (NOLOCK)
LEFT OUTER JOIN dbo.cft_PARTIAL_TICKET cft_PARTIAL_TICKET (NOLOCK)
	ON cft_PARTIAL_TICKET.FullTicketID = cft_CORN_TICKET.TicketID
LEFT OUTER JOIN dbo.cft_FEED_MILL cft_FEED_MILL (NOLOCK)
	ON cft_FEED_MILL.FeedMillID = cft_CORN_TICKET.FeedMillID
LEFT OUTER JOIN dbo.cft_COMMODITY cft_COMMODITY
	ON cft_COMMODITY.CommodityID = cft_CORN_TICKET.CommodityID
WHERE	convert(varchar,cft_CORN_TICKET.DeliveryDate,101) BETWEEN @StartDate AND @EndDate
AND	cft_CORN_TICKET.Moisture BETWEEN @StartRange AND @EndRange
AND	cft_FEED_MILL.FeedMillID LIKE RTRIM(@FeedMillID)
AND	(cft_CORN_TICKET.CommodityID like @CommodityID)
GROUP BY
	cft_FEED_MILL.Name
,	cft_CORN_TICKET.DestinationFarmBin
,	CONVERT(VARCHAR,cft_CORN_TICKET.DeliveryDate,101)--cft_CORN_TICKET.DeliveryDate
,	CASE WHEN @CommodityID = '%' THEN 'All Commodities' ELSE cft_COMMODITY.Description END
ORDER BY
	Commodity
,	cft_FEED_MILL.Name
,	cft_CORN_TICKET.DestinationFarmBin
,	CONVERT(VARCHAR,cft_CORN_TICKET.DeliveryDate,101)

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TOTAL_BUSHELS_BY_MOISTURE_RANGE] TO [db_sp_exec]
    AS [dbo];


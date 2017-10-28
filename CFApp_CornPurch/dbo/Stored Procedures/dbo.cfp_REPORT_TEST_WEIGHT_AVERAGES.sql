
-- =============================================
-- Author:		Matt Dawson
-- Create date: 08/14/2008
-- Description:	Returns Test Weight and Bushel information on tickets within
--	date range for Feed Mill
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_TEST_WEIGHT_AVERAGES]
(	@StartDate DATETIME
,	@EndDate DATETIME
,	@FeedMillID CHAR(10)
,	@CommodityID int
,	@CornProducerID varchar(15)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT
	cft_FEED_MILL.Name 'FeedMill'
,	cft_CORN_TICKET.DestinationFarmBin 'BinName'
,	CONVERT(VARCHAR,cft_CORN_TICKET.DeliveryDate,101) 'DeliveryDate'
,	COALESCE(AVG(cft_CORN_TICKET.TestWeight),0) 'AvgTestWeight'
,	COALESCE(SUM(PartialTicket.DryBushels),0) 'SumDryBushels'
,	CASE WHEN @CommodityID = 0 THEN 'All Commodities' ELSE cft_COMMODITY.Description END 'Commodity'
FROM		dbo.cft_CORN_TICKET cft_CORN_TICKET (NOLOCK)
LEFT OUTER JOIN dbo.cft_PARTIAL_TICKET  PartialTicket
	ON	PartialTicket.FullTicketID = cft_CORN_TICKET.TicketID
LEFT OUTER JOIN dbo.cft_Vendor V ON V.VendId = ISNULL(PartialTicket.DeliveryCornProducerID, PartialTicket.CornProducerID)
LEFT OUTER JOIN dbo.cft_FEED_MILL cft_FEED_MILL (NOLOCK)
	ON cft_FEED_MILL.FeedMillID = cft_CORN_TICKET.FeedMillID
LEFT OUTER JOIN dbo.cft_COMMODITY cft_COMMODITY
	ON cft_COMMODITY.CommodityID = cft_CORN_TICKET.CommodityID
WHERE	CONVERT(VARCHAR,cft_CORN_TICKET.DeliveryDate,101) BETWEEN @StartDate AND @EndDate
AND	cft_FEED_MILL.FeedMillID LIKE RTRIM(@FeedMillID)
AND	(@CommodityID = 0 OR cft_CORN_TICKET.CommodityID = @CommodityID)
AND 	V.VendID LIKE @CornProducerID
GROUP BY
	cft_FEED_MILL.Name
,	cft_CORN_TICKET.DestinationFarmBin
,	CONVERT(VARCHAR,cft_CORN_TICKET.DeliveryDate,101)
,	CASE WHEN @CommodityID = 0 THEN 'All Commodities' ELSE cft_COMMODITY.Description END
ORDER BY
	cft_FEED_MILL.Name
,	CONVERT(VARCHAR,cft_CORN_TICKET.DeliveryDate,101)
,	cft_CORN_TICKET.DestinationFarmBin


END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TEST_WEIGHT_AVERAGES] TO [db_sp_exec]
    AS [dbo];


-- =============================================
-- Author:		Matt Dawson
-- Create date: 08/14/2008
-- Description:	Returns Moisture and Bushel information on tickets within
--	date range for Feed Mill
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_MOISTURE_AVERAGES]
(	@StartDate DATETIME
,	@EndDate DATETIME
,	@FeedMillID CHAR(10)
,	@SentToDryer CHAR(1)
,	@CommodityID int
,	@CornProducerID	varchar(15)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT	FeedMill
,	BinName
,	DeliveryDate
,	AVG(AvgMoisture) AvgMoisture
,	SUM(SumDryBushels) SumDryBushels
,	SUM(SumWetBushels) SumWetBushels
,	Commodity
FROM
(	SELECT
		cft_FEED_MILL.Name 'FeedMill'
	,	cft_CORN_TICKET.DestinationFarmBin 'BinName'
	,	CONVERT(VARCHAR,cft_CORN_TICKET.DeliveryDate,101) 'DeliveryDate'
	,	CAST(COALESCE(AVG(cft_CORN_TICKET.Moisture),0) AS NUMERIC(18,2)) 'AvgMoisture'
	,	COALESCE(SUM(cft_PARTIAL_TICKET.DryBushels),0) 'SumDryBushels'
	,	COALESCE(SUM(cft_PARTIAL_TICKET.WetBushels),0) 'SumWetBushels'
	,	CASE WHEN @CommodityID = 0 THEN 'All Commodities' ELSE cft_COMMODITY.Description END 'Commodity'
	,	cft_CORN_TICKET.TicketID
	FROM		dbo.cft_PARTIAL_TICKET cft_PARTIAL_TICKET (NOLOCK)
	LEFT OUTER JOIN dbo.cft_CORN_TICKET cft_CORN_TICKET (NOLOCK)
		ON cft_CORN_TICKET.TicketID = cft_PARTIAL_TICKET.FullTicketID
	LEFT OUTER JOIN dbo.cft_INVENTORY_BATCH cft_INVENTORY_BATCH (NOLOCK)
		ON cft_INVENTORY_BATCH.TicketNumber = cft_CORN_TICKET.TicketNumber
	LEFT OUTER JOIN dbo.cft_Vendor V ON V.VendId = cft_CORN_TICKET.CornProducerID
	LEFT OUTER JOIN dbo.cft_FEED_MILL cft_FEED_MILL (NOLOCK)
		ON cft_FEED_MILL.FeedMillID = cft_CORN_TICKET.FeedMillID
	LEFT OUTER JOIN dbo.cft_COMMODITY cft_COMMODITY
		ON cft_COMMODITY.CommodityID = cft_CORN_TICKET.CommodityID
	WHERE	CONVERT(VARCHAR,cft_CORN_TICKET.DeliveryDate,101) BETWEEN @StartDate AND @EndDate
	AND	cft_CORN_TICKET.SentToDryer LIKE @SentToDryer
	AND	cft_FEED_MILL.FeedMillID LIKE RTRIM(@FeedMillID)
	AND	(@CommodityID = 0 OR cft_CORN_TICKET.CommodityID = @CommodityID)
	AND	V.VendID LIKE @CornProducerID
	GROUP BY
		cft_FEED_MILL.Name
	,	cft_CORN_TICKET.DestinationFarmBin
	,	CONVERT(VARCHAR,cft_CORN_TICKET.DeliveryDate,101)
	,	CASE WHEN @CommodityID = 0 THEN 'All Commodities' ELSE cft_COMMODITY.Description END
	,	cft_CORN_TICKET.TicketID) calctbl

GROUP BY FeedMill, BinName, DeliveryDate, Commodity
ORDER BY
	FeedMill
,	DeliveryDate
,	BinName

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MOISTURE_AVERAGES] TO [db_sp_exec]
    AS [dbo];


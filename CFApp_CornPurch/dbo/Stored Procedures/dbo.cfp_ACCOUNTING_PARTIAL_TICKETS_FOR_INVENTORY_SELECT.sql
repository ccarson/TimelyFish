-- =========================================================================================
-- Author:		Brian Cesafsky
-- Create date: 08/20/2008
-- Description:	Returns a list of partial tickets that can be sent to acccounting inventory
-- =========================================================================================
CREATE PROCEDURE [dbo].[cfp_ACCOUNTING_PARTIAL_TICKETS_FOR_INVENTORY_SELECT]
(
	@FromDate				datetime
	,@ToDate				datetime
	,@FeedMillID			char(10)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT PT.TicketNumber
			,PT.DeliveryDate
			,SUM(PT.DryBushels) 'SumDryBushels'
			,CT.Commodity
			,COALESCE(C.Description,'') 'CommodityDescription'
	FROM dbo.cft_PARTIAL_TICKET PT (NOLOCK)
	LEFT OUTER JOIN   dbo.cft_CORN_TICKET CT (NOLOCK)
      ON CT.TicketID = PT.FullTicketID
	LEFT OUTER JOIN dbo.cft_COMMODITY C (NOLOCK)
      ON RTRIM(C.Name) = RTRIM(CT.Commodity)
	WHERE PT.PartialTicketStatusID <> 2
	AND PT.DeliveryDate between @FromDate and @ToDate
	AND CT.FeedMillID = @FeedMillID
	GROUP BY PT.TicketNumber
            ,PT.DeliveryDate
            ,CT.Commodity
            ,C.Description
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_ACCOUNTING_PARTIAL_TICKETS_FOR_INVENTORY_SELECT] TO [db_sp_exec]
    AS [dbo];



-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 01/18/2008
-- Description:	Selects records from the table cftMarketSaleType
-- =============================================
CREATE PROCEDURE [dbo].[cfp_MARKET_SALE_TYPE_SELECT_BY_TYPE]
(
	@MarketSaleTypeID			char(2)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
		MarketSaleTypeID
		, Description
		, LoadTimeMinutes
		, MarketTotalType
	FROM
		[$(SolomonApp)].dbo.cftMarketSaleType WITH (NOLOCK)
	WHERE 
		MarketSaleTypeID = @MarketSaleTypeID
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_SALE_TYPE_SELECT_BY_TYPE] TO [db_sp_exec]
    AS [dbo];


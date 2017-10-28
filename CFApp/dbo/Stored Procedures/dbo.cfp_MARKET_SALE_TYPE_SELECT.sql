
-- =============================================
-- Author:		Dave Killion
-- Create date: 11/29/2007
-- Description:	Selects records from the table cftMarketSaleType
-- =============================================
CREATE PROCEDURE [dbo].[cfp_MARKET_SALE_TYPE_SELECT]
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		Description
		,MarketSaleTypeID
	FROM
		[$(SolomonApp)].dbo.cftMarketSaleType WITH (NOLOCK)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_SALE_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];


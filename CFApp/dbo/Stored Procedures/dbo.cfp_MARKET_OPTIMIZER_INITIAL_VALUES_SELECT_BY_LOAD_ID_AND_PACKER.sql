-- ================================================================================
-- Author:		Brian Cesafsky
-- Create date: 09/27/2010
-- Description:	Returns the values  based on calculating option, contact, and Load
-- ================================================================================
CREATE PROCEDURE [dbo].[cfp_MARKET_OPTIMIZER_INITIAL_VALUES_SELECT_BY_LOAD_ID_AND_PACKER]
(
	@MarketLoadID				int
	,@ContactID					int
	,@CalculatingOptionID		int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT [MarketOptimizerID]
		  ,[LoadID]
		  ,[CalculatingOptionID]
		  ,[ContactID]
		  ,[EstimatedQuantity]
		  ,[EstimatedWeight]
		  ,[MovementDate]
		  ,[Ignore]
		  ,[OutByDay]
		  ,[BasePrice]
		  ,[BaseDollarAmount]
		  ,[SortAmount]
		  ,[LeanAmount]
		  ,[FixedCost]
		  ,[TransportationCost]
		  ,[NetLoadAmount]
	FROM [dbo].[cft_MARKET_OPTIMIZER]
	WHERE LoadID = @MarketLoadID
	AND ContactID = @ContactID
	AND CalculatingOptionID = @CalculatingOptionID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_OPTIMIZER_INITIAL_VALUES_SELECT_BY_LOAD_ID_AND_PACKER] TO [db_sp_exec]
    AS [dbo];


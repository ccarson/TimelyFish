-- ================================================================================
-- Author:		Brian Cesafsky
-- Create date: 11/03/2010
-- Description:	Returns the values based on calculating option, contact, and Dates
-- ================================================================================
CREATE PROCEDURE [dbo].[cfp_MARKET_OPTIMIZER_INITIAL_VALUES_SELECT_BY_DATE_AND_PACKER]
(
	@LoadDate					datetime
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
	WHERE ContactID = @ContactID
	AND CalculatingOptionID = @CalculatingOptionID
	AND MovementDate = @LoadDate
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_OPTIMIZER_INITIAL_VALUES_SELECT_BY_DATE_AND_PACKER] TO [db_sp_exec]
    AS [dbo];


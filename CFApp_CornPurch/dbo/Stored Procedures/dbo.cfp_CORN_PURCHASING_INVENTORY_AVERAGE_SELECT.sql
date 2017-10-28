-- ======================================================================
-- Author:		Matt Dawson
-- Create date: 08/01/2008
-- Description:	get inventory averages
-- ======================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_INVENTORY_AVERAGE_SELECT]
(
	@FeedMillID VARCHAR(10)
,	@CommodityID INT
,	@NumberOfDays INT
)
AS
BEGIN

--sproc required parameters
DECLARE @mysql NVARCHAR(4000)
DECLARE @myUsage NUMERIC(15,2)
DECLARE @myReceived NUMERIC(15,2)
DECLARE @ParmDefinition NVARCHAR(4000)
SET @ParmDefinition = N'@FeedMillID VARCHAR(10), @CommodityID INT, @myVarOUT NUMERIC(15,2) OUTPUT'

SET @mysql = 'SELECT @myVarOUT = AVG(DailyVals.DailyUsage) FROM (SELECT TOP ' + CAST(@NumberOfDays AS VARCHAR) + ' DailyUsage '
	+ 'FROM dbo.cft_CORN_PURCHASING_INVENTORY (NOLOCK) '
	--+ 'WHERE	DailyUsage <> 0 '
	+ 'WHERE FeedMillID = @FeedMillID '
	+ 'AND CommodityID = @CommodityID '
	+ 'ORDER BY InventoryDate DESC) DailyVals'
exec sp_executesql @mysql
	, @ParmDefinition
	, @FeedMillID = @FeedMillID
	, @CommodityID = @CommodityID
	, @myVarOUT = @myUsage OUTPUT


SET @mysql = 'SELECT @myVarOUT = AVG(DailyVals.DailyReceived) FROM (SELECT TOP ' + CAST(@NumberOfDays AS VARCHAR) + ' DailyReceived '
	+ 'FROM dbo.cft_CORN_PURCHASING_INVENTORY (NOLOCK) '
	--+ 'WHERE	DailyReceived <> 0 '
	+ 'WHERE FeedMillID = @FeedMillID '
	+ 'AND CommodityID = @CommodityID '
	+ 'ORDER BY InventoryDate DESC) DailyVals'
exec sp_executesql @mysql
	, @ParmDefinition
	, @FeedMillID = @FeedMillID
	, @CommodityID = @CommodityID
	, @myVarOUT = @myReceived OUTPUT
select @myReceived 'DailyReceived', @myUsage 'DailyUsage'
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_INVENTORY_AVERAGE_SELECT] TO [db_sp_exec]
    AS [dbo];


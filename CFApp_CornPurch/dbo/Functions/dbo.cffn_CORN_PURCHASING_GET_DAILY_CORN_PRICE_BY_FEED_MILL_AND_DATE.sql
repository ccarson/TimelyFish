
-- =============================================
-- Author:	mdawson
-- Create date: 02/24/2009
-- Description:	Returns value from daily price for given feed mill and date
-- =============================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_GET_DAILY_CORN_PRICE_BY_FEED_MILL_AND_DATE]
(
    @FeedMillID		char(10),
    @Date		datetime
)
RETURNS decimal(20,4)
AS
BEGIN

  DECLARE @Result decimal(18,4)
  set @Result = (select top 1 dpd.price
	from cft_daily_price_detail dpd (nolock)
	inner join cft_daily_price dp (nolock)
		on dp.dailypriceid = dpd.dailypriceid
	where dp.Date <= @Date
	and dp.approved = 1
	and rtrim(dp.FeedMillID) = rtrim(@FeedMillID)
	order by dp.date desc, dpd.dailypricedetailid)


  RETURN @Result
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GET_DAILY_CORN_PRICE_BY_FEED_MILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];


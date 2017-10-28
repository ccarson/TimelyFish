
-- ===================================================================
-- Author:	Stephen Ripley
-- Create date: 07/14/2011
-- Description:	Selects DailyPrice record for DailyPriceReport.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CornPurch_Tool]
(
   @FeedMillID		char(10),
   @DeliveryYear	smallint,
   @DeliveryMonth	tinyint,
   @StartDate		datetime,
   @EndDate			datetime
)
AS
BEGIN
SET NOCOUNT ON;

select 
dp.feedmillid
, dpd.deliverydate as CFF_Delivery_Month_Year
, dp.date   
, fin.name as optionmonth
, dpd.cbotcornclose, dpd.cbotchange 
, c.name
, (dpdc.price - dpd.cbotcornclose) as Basis
, dpdc.price  
, 1 sortorder
, deliverydateto
, deliverydatefrom
from dbo.cft_DAILY_PRICE as DP
      join dbo.cft_DAILY_PRICE_DETAIL as dpd on dp.dailypriceid = dpd.dailypriceid
      join dbo.cft_financial_month as fin on dpd.optionmonth = fin.financialmonthid
      join dbo.cft_DAILY_PRICE_DETAIL_COMPETITOR as DPDC on dpd.dailypricedetailid = dpdc.dailypricedetailid
      join dbo.cft_Competitor as C on dpdc.Competitorid = c.Competitorid
where 1=1 
and dpd.deliveryyear = @DeliveryYear and dpd.deliverymonth = @DeliveryMonth
and dp.approved = 1 and dp.feedmillid = @feedmillid
and dp.date between @StartDate and @EndDate
union
select
dp.feedmillid
, dpd.deliverydate as CFF_Delivery_Month_Year
, dp.date  
, fin.name as optionmonth
, dpd.cbotcornclose, dpd.cbotchange 
, 'CFF (CFF_Basis,CFF_BID)', (dpd.price - dpd.cbotcornclose) as Basis, dpd.price as price
, 0 sortorder
, deliverydateto
, deliverydatefrom
from dbo.cft_DAILY_PRICE as DP
      join dbo.cft_DAILY_PRICE_DETAIL as dpd on dp.dailypriceid = dpd.dailypriceid
      join dbo.cft_financial_month as fin on dpd.optionmonth = fin.financialmonthid
where 1=1 
and dpd.deliveryyear = @DeliveryYear and dpd.deliverymonth = @DeliveryMonth
and dp.approved = 1 and dp.feedmillid = @FeedMillID
and dp.date between @StartDate and @EndDate
order by  dp.feedmillid
, dpd.deliverydate 
, dp.date 
, sortorder  
, fin.name  
, c.name



END







GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CornPurch_Tool] TO [SE\Earth~CFApp_CornPurch~DataReader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CornPurch_Tool] TO [db_sp_exec]
    AS [dbo];


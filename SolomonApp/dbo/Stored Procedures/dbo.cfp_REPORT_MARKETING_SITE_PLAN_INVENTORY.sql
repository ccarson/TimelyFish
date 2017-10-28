-- =============================================
-- Author:		Matt Brandt
-- Create date: 10/11/2010
-- Description:	This procedure makes the Inventory dataset for the Marketing Site Plan report.
-- =============================================
CREATE PROCEDURE dbo.cfp_REPORT_MARKETING_SITE_PLAN_INVENTORY 
	-- Add the parameters for the stored procedure here
	@SiteContactID Char(6) 
	
AS
BEGIN

SET NOCOUNT ON;

-----------
--Inventory
-----------

Declare @Inventory Table

(BarnNumber Char(6)
, PigGroupID Char(10)
, Headcount Float
, FillStartDate Datetime
, FillEndDate Datetime
, EstWeightGrowthCurve Float
, EstWeightFeedBin Float
, DaysOnFeed Int
, EstStartWeight Float
, PigDay Int
, ExpectedFeedConsumption Float
, ActualFeedConsumed Float
, FeedConsumptionRate Float
)

Insert Into @Inventory

Select RTrim(pg.BarnNbr) As BarnNumber
, RTrim(pg.PigGroupID) As PigGroupID
, hc.Headcount As Headcount
, fd.FillStartDate
, fd.FillEndDate
, SolomonApp_dw.dbo.cffn_GROWTH_CURVE_CALCULATOR(EstStartWeight,DateDiff(dd,fd.FillStartDate,GetDate())) As EstWeightGrowthCurve
, Null As EstWeightFeedBin
, DateDiff(dd,fd.FillStartDate,GetDate()) As DaysOnFeed
, EstStartWeight As EstimatedStartWeight
, (Select Top 1 PigDay From SolomonApp_dw.dbo.cft_GROWTH_AND_FEED_CONSUMPTION_CURVE Where PigWeight >= EstStartWeight Order By PigDay)-1 As PigDay
, Null As ExpectedFeedConsumption
, feed.TotalFeedDelivered As ActualFeedConsumed
, Null As FeedConsumptionRate

From SolomonApp.dbo.cftPigGroup pg
	Inner Join (  --Find the Earliest and Latest Arrival Dates for each Pig Group
				Select fd.DestPigGroupID, Min(fd.ArrivalDate) As FillStartDate, Max(fd.ArrivalDate) As FillEndDate
				From SolomonApp.dbo.cftPigGroup pg
					Inner Join SolomonApp.dbo.cftPM fd On fd.DestPigGroupID = pg.PigGroupID
				Group By fd.DestPigGroupID
				) fd On fd.DestPigGroupID = pg.PigGroupID
	Inner Join (  --Find the Feed Delivered for each Pig Group
				Select feed.PigGroupID, Sum(feed.QtyDel) As TotalFeedDelivered
				From SolomonApp.dbo.cftPigGroup pg
					Inner Join SolomonApp.dbo.cftFeedOrder feed On feed.PigGroupID = pg.PigGroupID
				Group By feed.PigGroupID
				) feed On feed.PigGroupID = pg.PigGroupID
	Inner Join (  --Headcount
				Select pg.PigGroupID, SUM(hc.Qty * hc.InvEffect) AS Headcount
				From SolomonApp.dbo.cftPigGroup As pg WITH (NOLOCK)
					Inner Join SolomonApp.dbo.cftPGInvTran As hc WITH (NOLOCK) On pg.PigGroupID = hc.PigGroupID
				Where (hc.Reversal <> 1) and pg.PGStatusID<>'I'
				Group By pg.PigGroupID
				) hc On hc.PigGroupID = pg.PigGroupID

Where pg.CF03 = (Select Top 1 CF03 --Current MastergroupID
				From SolomonApp.dbo.cftPigGroup 
				Where SiteContactID = @SiteContactID 
				Order By ActStartDate Desc)
				
Order By BarnNumber

Declare @StartDate Datetime
Select @StartDate = Min(FillStartDate) From @Inventory


Declare @DailyInventory Table
(InventoryDate datetime, PigGroupID Char(10), Headcount Int, ExpectedFeedConsumption Float, LookupDays Int)

While @StartDate <= DateAdd(dd,DateDiff(dd,0,GetDate()),0)

Begin
	Insert Into @DailyInventory
	Select @StartDate, i.PigGroupID, Null, Null, i.PigDay+DateDiff(dd,FillStartDate,@StartDate) As LookupDays
	From @Inventory i
	Where @StartDate Between FillStartDate And DateAdd(dd,DateDiff(dd,0,GetDate()),0)
	Set @StartDate = DateAdd(dd,1,@StartDate)
End

Update d

Set Headcount = (
SELECT SUM(t.Qty * t.InvEffect)
FROM
SolomonApp.dbo.cftPigGroup AS pg WITH (NOLOCK)
LEFT OUTER JOIN SolomonApp.dbo.cftPGInvTran AS t WITH (NOLOCK)
ON pg.PigGroupID = t.PigGroupID
WHERE     (t.Reversal <> 1)
and (t.TranDate<=d.InventoryDate)
and pg.PGStatusID<>'I'
and pg.PigGroupID = d.PigGroupID
GROUP BY pg.ProjectID, pg.TaskID
)

From @DailyInventory d

Update d
Set ExpectedFeedConsumption = 
		(
		Select cur.FeedConsumption
		From SolomonApp_dw.dbo.cft_GROWTH_AND_FEED_CONSUMPTION_CURVE cur
		Where cur.PigDay = d.LookupDays
		) * d.Headcount

From @DailyInventory d

Update i
Set ExpectedFeedConsumption = 
	(
	Select Sum(d.ExpectedFeedConsumption) 
	From @DailyInventory d
	Where d.PigGroupID = i.PigGroupID 
	Group By i.PigGroupID
	)
From @Inventory i

Update i
Set FeedConsumptionRate = ActualFeedConsumed/ExpectedFeedConsumption
From @Inventory i

Update i
Set EstWeightFeedBin = EstWeightGrowthCurve*FeedConsumptionRate
From @Inventory i

Select *
From @Inventory

END

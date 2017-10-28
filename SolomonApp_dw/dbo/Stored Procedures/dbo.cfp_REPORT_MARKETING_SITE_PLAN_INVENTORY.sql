-- =============================================
-- Author:		Matt Brandt
-- Create date: 10/11/2010
-- Description:	This procedure makes the Inventory dataset for the Marketing Site Plan report.
-- =============================================
CREATE PROCEDURE dbo.cfp_REPORT_MARKETING_SITE_PLAN_INVENTORY 
	-- Add the parameters for the stored procedure here
	@SiteName Char(50) 
	,@FirstTopPercent float
	,@SecondTopPercent float
	,@ThirdTopPercent float
	,@HeavyCloseoutPercent float
	,@LightCloseoutPercent float
	
AS
BEGIN

SET NOCOUNT ON;

SET NOCOUNT ON;
 
Declare @SiteContactID Char(6)

Select @SiteContactID = SiteContactID From  dbo.cfv_Site Where RTrim(SiteContactName) = RTrim(@SiteName)

-----------
--Inventory
-----------

Declare @Inventory Table

(BarnNumber Char(6)
, PigGroupID Char(10)
, Headcount Float
, FillStartDate Datetime
, FillEndDate Datetime
, EstimatedCurrentWeight Float
, EstimatedPigAge Int
, DaysOnFeed Int
, EstStartWeight Float
, ActualFeedDelivered Float
, ActualFeedConsumed Float
, ActualFeedConsumedPerPig Float
, LastFeedDeliveryDate Datetime
, LastFeedDeliveryAmount Float
, BaseFeedEfficiency Float
, TriumphEligibility Char(3)
, TopPacker Char(20)
, HeavyCloseoutPacker Char(20)
, LightCloseoutPacker Char(20)
, FirstTopPercent Float
, SecondTopPercent Float
, ThirdTopPercent Float
, HeavyCloseoutPercent Float
, LightCloseoutPercent Float
)

Insert Into @Inventory

Select RTrim(pg.BarnNbr) As BarnNumber
, RTrim(pg.PigGroupID) As PigGroupID
, hc.Headcount As Headcount
, fd.FillStartDate
, fd.FillEndDate
, Case When 21+n.NurseryDays+DateDiff(dd,fd.FillStartDate,GetDate()) >= 114 Then Null
	Else  dbo.cffn_GROWTH_CURVE_CALCULATOR(EstStartWeight,DateDiff(dd,fd.FillStartDate,GetDate()))
	End As EstimatedCurrentWeight
, 21 --Assumed Wean Pig Days
	+n.NurseryDays
	+DateDiff(dd,fd.FillStartDate,GetDate()) As EstimatedPigAge
, DateDiff(dd,fd.FillStartDate,GetDate()) As DaysOnFeed
, EstStartWeight As EstimatedStartWeight
, feed.TotalFeedDelivered As ActualFeedDelivered
, Null As ActualFeedConsumed
, Null As ActualFeedConsumedPerPig
, (Select Max(lf.DateDel) From [$(SolomonApp)].dbo.cftFeedOrder lf Where lf.PigGroupID = pg.PigGroupID) As LastFeedDeliveryDate
, (Select Sum(lfa.QtyDel) From [$(SolomonApp)].dbo.cftFeedOrder lfa Where lfa.PigGroupID = pg.PigGroupID
	And lfa.DateDel = (Select Max(lf.DateDel) From [$(SolomonApp)].dbo.cftFeedOrder lf Where lf.PigGroupID = pg.PigGroupID)) As LastFeedDeliveryAmount
,  dbo.cffn_Feed_Efficiency_By_Flow(
	--PigFlowID
	(Select Top 1 pf.PigFlowID From  dbo.cft_PIG_GROUP_CENSUS pf Where pg.PigGroupID = pf.PigGroupID Order By pf.CurrentInv Desc) 
	--Phase
	, pg.PigProdPhaseID 
	--Gender
	, Left(PigGenderTypeID,1) 
	--Current Date
	, GetDate() 
	) As BaseFeedEfficiency
, Case When feed.NonTriumphFeed > 0 Then 'No' Else 'Yes' End As TriumphEligibility
, Case When feed.NonTriumphFeed > 0 Then 'Tyson' Else 'Triumph' End As TopPacker
, Case When feed.NonTriumphFeed > 0 Then 'Tyson' Else 'Triumph' End As HeavyPacker
, 'Swift'
, @FirstTopPercent as FirstTopPercent
--Case When feed.NonTriumphFeed > 0 Then 10 Else 20 End As FirstTopPercent
, @SecondTopPercent as SecondTopPercent
--Case When feed.NonTriumphFeed > 0 Then 20 Else 0 End As SecondTopPercent
, @ThirdTopPercent as ThirdTopPercent
--0 As ThirdTopPercent
, @HeavyCloseoutPercent
--Case When feed.NonTriumphFeed > 0 Then 20 Else 50 End As HeavyCloseoutPercent
, @LightCloseoutPercent
--Case When feed.NonTriumphFeed > 0 Then 50 Else 30 End As LightCloseoutPercent

From [$(SolomonApp)].dbo.cftPigGroup pg
	Inner Join (  --Find the Earliest and Latest Arrival Dates for each Pig Group
				Select fd.DestPigGroupID, Min(fd.ArrivalDate) As FillStartDate, Max(fd.ArrivalDate) As FillEndDate
				From [$(SolomonApp)].dbo.cftPigGroup pg
					Inner Join [$(SolomonApp)].dbo.cftPM fd On fd.DestPigGroupID = pg.PigGroupID
				Group By fd.DestPigGroupID
				) fd On fd.DestPigGroupID = pg.PigGroupID
	Inner Join (  --Find the Feed Delivered for each Pig Group
				Select feed.PigGroupID
				, Sum(feed.QtyDel) As TotalFeedDelivered
				, Sum(Case When feed.InvtIdDel In('053M-NT','054M-NT','055M-NT') Then feed.QtyDel Else 0 End) As NonTriumphFeed
				From [$(SolomonApp)].dbo.cftPigGroup pg
					Inner Join [$(SolomonApp)].dbo.cftFeedOrder feed On feed.PigGroupID = pg.PigGroupID
				Where feed.Reversal = '0'
				Group By feed.PigGroupID
				) feed On feed.PigGroupID = pg.PigGroupID
	Inner Join (  --Headcount
				Select pg.PigGroupID, SUM(hc.Qty * hc.InvEffect) AS Headcount
				From [$(SolomonApp)].dbo.cftPigGroup As pg WITH (NOLOCK)
					Inner Join [$(SolomonApp)].dbo.cftPGInvTran As hc WITH (NOLOCK) On pg.PigGroupID = hc.PigGroupID
				Where (hc.Reversal <> 1) and pg.PGStatusID<>'I'
				Group By pg.PigGroupID
				) hc On hc.PigGroupID = pg.PigGroupID
	Left Join (  --Nursery Days
				Select p.PigGroupID, Sum(p.PigQuantity*p.NurseryDays)/Sum(p.PigQuantity) As NurseryDays
				From [$(SolomonApp)].dbo.cftPigGroup pg
					Inner Join (
						Select i.PigGroupID,i.SourcePigGroupID, i.PigQuantity, pgr.LivePigDays/pgr.TotalHeadProduced As NurseryDays
						From  dbo.cft_PIG_GROUP_ROLLUP pgr
							Inner Join (
								Select i.PigGroupID, i.SourcePigGroupID, Sum(i.Qty) As PigQuantity
								From [$(SolomonApp)].dbo.cftPGInvTran i
									Inner Join [$(SolomonApp)].dbo.cftPigGroup pg On pg.PigGroupID = i.PigGroupID
								Where i.SourcePigGroupID != ' ' And i.Reversal = 0 
									And pg.CF03 = (Select Top 1 CF03 --Current MastergroupID
													From [$(SolomonApp)].dbo.cftPigGroup 
													Where SiteContactID = @SiteContactID 
													Order By ActStartDate Desc)
								Group By i.PigGroupID, i.SourcePigGroupID
								) i On RTrim(i.SourcePigGroupID) = RTrim(Substring(pgr.TaskID,3,10))
						Where pgr.Phase = 'NUR'
						) p On p.PigGroupID = pg.PigGroupID
				Group By p.PigGroupID
				) n On n.PigGroupID = pg.PigGroupID

Where pg.CF03 = (Select Top 1 CF03 --Current MastergroupID
				From [$(SolomonApp)].dbo.cftPigGroup 
				Where SiteContactID = @SiteContactID 
				Order By ActStartDate Desc)
				
Order By BarnNumber

----------------------------------------------------------
--Determine the Total Feed Eaten by the Pig Group,
--backing out feed likely still in the bins
----------------------------------------------------------

Update i
Set ActualFeedConsumed = ActualFeedDelivered - (LastFeedDeliveryAmount - Headcount*5.5*DateDiff(dd,LastFeedDeliveryDate,DateAdd(dd,DateDiff(dd,0,GetDate()),0)))
From @Inventory i


---------------------------------------------------------
--Daily Inventory
---------------------------------------------------------

Declare @StartDate Datetime
Select @StartDate = Min(FillStartDate) From @Inventory


Declare @DailyInventory Table
(InventoryDate datetime, PigGroupID Char(10), CurrentHeadcount Float, Headcount Float, HeadcountDifference Float)

While @StartDate <= DateAdd(dd,DateDiff(dd,0,GetDate()),0)

Begin
	Insert Into @DailyInventory
	Select @StartDate, i.PigGroupID, Headcount As CurrentHeadcount, Null, Null
	From @Inventory i
	Where @StartDate Between FillStartDate And DateAdd(dd,DateDiff(dd,0,GetDate()),0)
	Set @StartDate = DateAdd(dd,1,@StartDate)
End

Update d

Set Headcount = (
SELECT SUM(t.Qty * t.InvEffect)
FROM
[$(SolomonApp)].dbo.cftPigGroup AS pg WITH (NOLOCK)
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPGInvTran AS t WITH (NOLOCK)
ON pg.PigGroupID = t.PigGroupID
WHERE     (t.Reversal <> 1)
and (t.TranDate<=d.InventoryDate)
and pg.PGStatusID<>'I'
and pg.PigGroupID = d.PigGroupID
GROUP BY pg.ProjectID, pg.TaskID
)

From @DailyInventory d

Update d
Set HeadcountDifference = Case When CurrentHeadcount >= Headcount Then 0 Else Headcount-CurrentHeadcount End
From @DailyInventory d

Update i
Set ActualFeedConsumedPerPig = 
	--Pig Days Eaten for Live Pigs
	(Select Sum(d.CurrentHeadcount) From @DailyInventory d 	Where d.PigGroupID = i.PigGroupID Group By i.PigGroupID)
	/
	(
	--Pig Days Eaten for Live Pigs
	(Select Sum(d.CurrentHeadcount) From @DailyInventory d 	Where d.PigGroupID = i.PigGroupID Group By i.PigGroupID)
	+
	--Pig Days Eaten for Dead Pigs
	(Select Sum(d.HeadcountDifference) From @DailyInventory d 	Where d.PigGroupID = i.PigGroupID Group By i.PigGroupID)
	)
	*ActualFeedConsumed/Headcount
From @Inventory i

Update i
Set EstimatedCurrentWeight =  dbo.cffn_PREMARKET_EVAL_WEIGHT_MODEL
	(BaseFeedEfficiency, EstStartWeight, ActualFeedConsumedPerPig, 1)
From @Inventory i
Where EstimatedCurrentWeight Is Null

Select *
From @Inventory

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MARKETING_SITE_PLAN_INVENTORY] TO [db_sp_exec]
    AS [dbo];


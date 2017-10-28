-- =============================================
-- Author:		Matt Brandt
-- Create date: 02/01/2011
-- Description:	This procedure makes the Action Plan dataset for the Marketing Site Plan report.
-- =============================================
CREATE PROCEDURE dbo.cfp_REPORT_MARKETING_SITE_PLAN_ACTION_PLAN 
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

Declare @SiteContactID Char(6)
Select @SiteContactID = SiteContactID From  dbo.cfv_Site Where RTrim(SiteContactName) = RTrim(@SiteName)

--------------------------------------
--Action Plan
--------------------------------------

-----------
--Inventory
-----------

If exists (SELECT * FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb..#Inventory'))
Begin
Drop table #Inventory
End

Create Table #Inventory

(RowID Int Not Null Identity(1,1)
, BarnNumber Char(6)
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

Insert Into #Inventory
Exec  dbo.cfp_REPORT_MARKETING_SITE_PLAN_INVENTORY 
@SiteName, 
@FirstTopPercent, 
@SecondTopPercent,
@ThirdTopPercent,
@HeavyCloseoutPercent,
@LightCloseoutPercent 

--Create the Results Table
If exists (SELECT * FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb..#MarketLoad'))
Begin
Drop table #MarketLoad
End

Create Table #MarketLoad
(LoadType Char(10)
, LoadID Char(10)
, PigGroupID Char(10)
, BarnNumber Char(6)
, LoadStatus Char(10)
, MovementDate datetime
, Destination Char(10)
, SystemDerivedAverageWeight Float
, EstimatedAverageWeight Float
, ActualAverageWeight Float
, PigsPerLoad Int)

Declare @PigGroupCounter Int
Declare @PigGroupID Char(6)
Declare @TotalPigGroups Int

Set @PigGroupCounter = 1
Select @TotalPigGroups = Max(RowID) From #Inventory

Declare @CurrentInventory Float
Declare @CurrentAverageWeight Float
Declare @BarnNumber Int
--Declare @FirstTopPercent Float
--Declare @SecondTopPercent Float
--Declare @ThirdTopPercent Float
--Declare @HeavyCloseoutPercent Float
--Declare @LightCloseoutPercent Float
Declare @TopPacker Char(20)
Declare @HeavyPacker Char(20)
Declare @LightPacker Char(20)

While @PigGroupCounter <= @TotalPigGroups

	Begin
	
	Select @PigGroupID = PigGroupID 
		, @CurrentInventory = Headcount
		, @CurrentAverageWeight = EstimatedCurrentWeight
		, @BarnNumber = BarnNumber
		, @FirstTopPercent = FirstTopPercent
		, @SecondTopPercent = SecondTopPercent
		, @ThirdTopPercent = ThirdTopPercent
		, @HeavyCloseoutPercent = HeavyCloseoutPercent
		, @LightCloseoutPercent = LightCloseoutPercent
		, @TopPacker = TopPacker
		, @HeavyPacker = HeavyCloseoutPacker
		, @LightPacker = LightCloseoutPacker
	From #Inventory 
	Where @PigGroupCounter = RowID
	
	Insert Into #MarketLoad

	Exec  dbo.cfp_DATA_MARKETING_SITE_PLAN_MARKET_LOAD_DETAIL
		@PigGroupID, @CurrentInventory, @CurrentAverageWeight, @BarnNumber
		, @FirstTopPercent, @SecondTopPercent, @ThirdTopPercent, @HeavyCloseoutPercent, @LightCloseoutPercent
		, @TopPacker, @HeavyPacker, @LightPacker
		
	Set @PigGroupCounter = @PigGroupCounter+1
	
	End
	
Declare @Event Table
(LoadType Char(10), PigGroupID Char(10), BarnNumber Char(6), LoadStatus Char(10), MovementDate datetime)

Insert Into @Event
	
Select Distinct RTrim(LoadType) As LoadType
, RTrim(PigGroupID) As PigGroupID
, RTrim(BarnNumber) As BarnNumber
, RTrim(LoadStatus) As LoadStatus
, MovementDate

From #MarketLoad

Order By MovementDate



Drop table #Inventory
Drop table #MarketLoad

--Select * From @Event

Declare @ActionPlan Table
(ActionDate DateTime,Activity Char(50))

-----------------------------------------------
--Site Preview
--Four Weeks Prior to the Earliest Topping Date
-----------------------------------------------
Insert Into @ActionPlan

Select Case When DatePart(dw,DateAdd(dd,-28,(Select MIN(MovementDate) From @Event))) = 7 
				Then DateAdd(dd,-29,(Select MIN(MovementDate) From @Event))
			When DatePart(dw,DateAdd(dd,-28,(Select MIN(MovementDate) From @Event))) = 1
				Then DateAdd(dd,-30,(Select MIN(MovementDate) From @Event))
			Else DateAdd(dd,-28,(Select MIN(MovementDate) From @Event)) End As ActionDate
, 'Site Preview' As Activity


------------------------------------------------
--Entering Loads
------------------------------------------------
Insert Into @ActionPlan

Select DateAdd(wk,-2,DateAdd(wk,DateDiff(wk,0,MovementDate),0)+3) As ActionDate
, Case When LoadType = 'Top' Then 'Enter Top Loads into the System for Barn '+BarnNumber
	When LoadType = 'Closeout' Then 'Enter Closeout Loads in the System for Barn '+BarnNumber
	Else Null End As Activity
From @Event
Where LoadStatus = 'Projected'

-------------------------------------------
--Marking Pigs
-------------------------------------------
Insert Into @ActionPlan

Select Case When DatePart(dw,DateAdd(dd,-4,MovementDate)) = 7 
				Then DateAdd(dd,-5,MovementDate)
			When DatePart(dw,DateAdd(dd,-4,MovementDate)) = 1
				Then DateAdd(dd,-3,MovementDate)
			Else DateAdd(dd,-4,MovementDate) End As ActionDate
, Case When LoadType = 'Top' Then 'Mark Tops in Barn '+BarnNumber
	When LoadType = 'Closeout' Then 'Mark Closeout in Barn '+BarnNumber
	Else Null End As Activity
From @Event
Where LoadStatus In ('Projected','Scheduled')


Select ActionDate, RTrim(Activity) As Activity
From @ActionPlan 
Where ActionDate Between DateAdd(dd,-7,DateAdd(dd,DateDiff(dd,0,GetDate()),0))
					And DateAdd(dd,14,DateAdd(dd,DateDiff(dd,0,GetDate()),0))
Order By ActionDate

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MARKETING_SITE_PLAN_ACTION_PLAN] TO [db_sp_exec]
    AS [dbo];


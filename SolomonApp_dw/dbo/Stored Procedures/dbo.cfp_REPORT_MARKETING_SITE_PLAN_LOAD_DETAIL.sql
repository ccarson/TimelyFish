-- =============================================
-- Author:		Matt Brandt
-- Create date: 01/11/2011
-- Description:	This procedure makes the Market Load Detail dataset for the Marketing Site Plan report.
-- =============================================
CREATE PROCEDURE dbo.cfp_REPORT_MARKETING_SITE_PLAN_LOAD_DETAIL 
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
--Market Load Detail
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
	
Select RTrim(LoadType) As LoadType
, RTrim(LoadID) As LoadID
, RTrim(PigGroupID) As PigGroupID
, RTrim(BarnNumber) As BarnNumber
, RTrim(LoadStatus) As LoadStatus
, MovementDate
, RTrim(Destination) As Destination
, SystemDerivedAverageWeight
, EstimatedAverageWeight
, ActualAverageWeight
, PigsPerLoad

From #MarketLoad

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MARKETING_SITE_PLAN_LOAD_DETAIL] TO [db_sp_exec]
    AS [dbo];


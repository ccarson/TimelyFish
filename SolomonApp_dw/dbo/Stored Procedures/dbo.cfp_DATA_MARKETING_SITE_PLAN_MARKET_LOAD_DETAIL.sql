-- =============================================
-- Author:		Matt Brandt
-- Create date: 02/17/2011
-- Description:	This procedure produces the actual or recommended market loads for a given PigGroupID.
-- =============================================
CREATE PROCEDURE dbo.cfp_DATA_MARKETING_SITE_PLAN_MARKET_LOAD_DETAIL 
@PigGroupID Char(6) 
, @CurrentInventory Float
, @CurrentAverageWeight Float
, @BarnNumber Int
, @FirstTopPercent Float
, @SecondTopPercent Float
, @ThirdTopPercent Float
, @HeavyCloseoutPercent Float
, @LightCloseoutPercent Float
, @TopPacker Char(20)
, @HeavyPacker Char(20)
, @LightPacker Char(20)

AS
BEGIN

SET NOCOUNT ON;

--Declare the Results Table
--This is the table Loads will be added to as they are found or generated
--It is the "final answer" for the proc
Declare @MarketLoad Table
(LoadType Char(10)
, LoadID Char(10)
, PigGroupID Char(10)
, BarnNumber Char(6)
, LoadStatus Char(10)
, MovementDate datetime
, Destination Char(20)
, SystemDerivedAverageWeight Float
, EstimatedAverageWeight Float
, ActualAverageWeight Float
, PigsPerLoad Int)

--Declare the variables used in the proc
Declare @AverageLoadWeight Float 
Declare @TotalLoads Float 
Declare @FirstTopLoads Float 
Declare @SecondTopLoads Float 
Declare @ThirdTopLoads Float 
Declare @LightLoads Int 
Declare @HeavyLoads Int 

--Currently this is set as a constant below.  There has been discussion of setting the number based on month in the year.
--If/When that decision is made, this constant should be converted to a formula with the new calculation.
Set @AverageLoadWeight = 47000

----------------------------------------------------------------------------------------------
--Find the Average Weight for each potential Topping Scenario

--We need to find the average weight where enough pigs are available in the barn to be topped.
----------------------------------------------------------------------------------------------

Declare @TargetTopWeight Float 
Declare @TargetCloseoutWeight Float 
Select @TargetTopWeight = TargetToppingWeight From  dbo.cft_PACKER_YIELD_ASSUMPTIONS Where Packer = @TopPacker
Select @TargetCloseoutWeight = TargetCloseoutWeight From  dbo.cft_PACKER_YIELD_ASSUMPTIONS Where Packer = @HeavyPacker


Declare @CV Float
Set @CV = .09

Declare @FirstTopWeight Float
Declare @SecondTopWeight Float
Declare @ThirdTopWeight Float

--These calculations use a normal distribution table and the assumed CV above to calculate the average weight required
--to have enough pigs available in the barn that average the Target Topping Weight.
Select @FirstTopWeight = @TargetTopWeight/(1+@CV*(Select ZScore From  dbo.cft_ZSCORE_PERCENTILE Where Percentile = (100-Floor(@FirstTopPercent/2)))) 
Select @SecondTopWeight = @TargetTopWeight/(1+@CV*(Select ZScore From  dbo.cft_ZSCORE_PERCENTILE Where Percentile = (100-Floor(@FirstTopPercent+@SecondTopPercent/2)))) 
Select @ThirdTopWeight = @TargetTopWeight/(1+@CV*(Select ZScore From  dbo.cft_ZSCORE_PERCENTILE Where Percentile = (100-Floor(@FirstTopPercent+@SecondTopPercent+@ThirdTopPercent/2))))

---------------------------------------------------------------------------------------
----Find the latest set of loads that have been entered in the system
--We need to know this so we know what phase the system should begin projecting loads.
---------------------------------------------------------------------------------------
Declare @MaxExistingMarketSaleTypeID Int
Select @MaxExistingMarketSaleTypeID = IsNull(Max(Cast(pm.MarketSaleTypeID As Int)),0)
	From [$(SolomonApp)].dbo.cftPM pm 
	Where @PigGroupID = pm.SourcePigGroupID
		And pm.MarketSaleTypeID Between 10 And 30

------------------------------------------------------
----Insert Any Loads that Exist into the Results Table
------------------------------------------------------
If @MaxExistingMarketSaleTypeID = 0 Goto Projected_Loads

Insert Into @MarketLoad
	
Select Case When pm.MarketSaleTypeID = 30 Then 'Closeout' Else 'Top' End As LoadType
, pm.PMLoadID as LoadID
, @PigGroupID
, @BarnNumber
, Case When pm.MovementDate < GetDate() Then 'Shipped' Else 'Scheduled' End As LoadStatus
, pm.MovementDate as MovementDate
, ps.Destination
, Null As SystemDerivedAverageWeight
, Cast(pm.EstimatedWgt As Int) as EstimatedAverageWeight
, ps.ActualAverageWeight as ActualAverageWeight
, pm.ActualQty As PigsPerLoad

From [$(SolomonApp)].dbo.cftPM pm
	Left Join (
			Select ps.PMLoadID
			, Case When ps.CustId Like('%TriFoo%') Then 'Triumph'
			When ps.CustId = 'Tys' Then 'Tyson'
			When ps.CustId = 'Swift' Then 'Swift'
			Else 'Other' End as Destination
			, Sum(ps.DelvLiveWgt)/Sum(ps.HCTot) As ActualAverageWeight
			From [$(SolomonApp)].dbo.cftPM pm
				Left Join [$(SolomonApp)].dbo.cfvPIGSALEREV ps On pm.PMLoadID = ps.PMLoadID
			Group By ps.PMLoadID, Case When ps.CustId Like('%TriFoo%') Then 'Triumph'
				When ps.CustId = 'Tys' Then 'Tyson'
				When ps.CustId = 'Swift' Then 'Swift'
				Else 'Other' End
				) ps On pm.PMLoadID = ps.PMLoadID

Where @PigGroupID = pm.SourcePigGroupID
	And pm.MarketSaleTypeID In(10,20,25,30)
	
	
-------------------------------------------
--Add any loads that need to be projected
-------------------------------------------
Projected_Loads:

Set @TotalLoads = Floor(@TargetCloseoutWeight*@CurrentInventory/@AverageLoadWeight)-(Select Count(*) From @MarketLoad Where LoadStatus = 'Scheduled')

Declare @DateTracker Datetime
Set @DateTracker = DateAdd(dd,DateDiff(dd,0,GetDate()),0)

------------------
--Allocate Loads
------------------
If @MaxExistingMarketSaleTypeID = 0
	Begin
	Set @FirstTopLoads = Case When @FirstTopPercent = 0 Then 0
		When Floor(@TotalLoads*@FirstTopPercent/100) < 1 Then 1 Else Floor(@TotalLoads*@FirstTopPercent/100) End
	Set @SecondTopLoads = Case When @SecondTopPercent = 0 Then 0
		When Floor(@TotalLoads*@SecondTopPercent/100) < 1 Then 1 Else Floor(@TotalLoads*@SecondTopPercent/100) End
	Set @ThirdTopLoads = Case When @ThirdTopPercent = 0 Then 0
		When Floor(@TotalLoads*@ThirdTopPercent/100) < 1 Then 1 Else Floor(@TotalLoads*@ThirdTopPercent/100) End
	Set @LightLoads = Round(@TotalLoads*@LightCloseoutPercent/100,0)
	Set @HeavyLoads = @TotalLoads-@FirstTopLoads-@SecondTopLoads-@ThirdTopLoads-@LightLoads
	End
	
If @MaxExistingMarketSaleTypeID = 10
	Begin
	Set @FirstTopLoads = 0
	Set @SecondTopLoads = Case When @SecondTopPercent = 0 Then 0
		When Floor(@TotalLoads*@SecondTopPercent/(@SecondTopPercent+@ThirdTopPercent+@LightCloseoutPercent+@HeavyCloseoutPercent)) < 1 Then 1 
		Else Floor(@TotalLoads*@SecondTopPercent/(@SecondTopPercent+@ThirdTopPercent+@LightCloseoutPercent+@HeavyCloseoutPercent)) End
	Set @ThirdTopLoads = Case When @ThirdTopPercent = 0 Then 0
		When Floor(@TotalLoads*@ThirdTopPercent/(@SecondTopPercent+@ThirdTopPercent+@LightCloseoutPercent+@HeavyCloseoutPercent)) < 1 Then 1 
		Else Floor(@TotalLoads*@ThirdTopPercent/(@SecondTopPercent+@ThirdTopPercent+@LightCloseoutPercent+@HeavyCloseoutPercent)) End
	Set @LightLoads = Round(@TotalLoads*@LightCloseoutPercent/(@SecondTopPercent+@ThirdTopPercent+@LightCloseoutPercent+@HeavyCloseoutPercent),0)
	Set @HeavyLoads = @TotalLoads-@FirstTopLoads-@SecondTopLoads-@ThirdTopLoads-@LightLoads
	End
	
If @MaxExistingMarketSaleTypeID = 20
	Begin
	Set @FirstTopLoads = 0
	Set @SecondTopLoads = 0
	Set @ThirdTopLoads = Case When @ThirdTopPercent = 0 Then 0
		When Floor(@TotalLoads*@ThirdTopPercent/(@ThirdTopPercent+@LightCloseoutPercent+@HeavyCloseoutPercent)) < 1 Then 1 
		Else Floor(@TotalLoads*@ThirdTopPercent/(@ThirdTopPercent+@LightCloseoutPercent+@HeavyCloseoutPercent)) End
	Set @LightLoads = Round(@TotalLoads*@LightCloseoutPercent/(@ThirdTopPercent+@LightCloseoutPercent+@HeavyCloseoutPercent),0)
	Set @HeavyLoads = @TotalLoads-@FirstTopLoads-@SecondTopLoads-@ThirdTopLoads-@LightLoads
	End
	
If @MaxExistingMarketSaleTypeID In(25,30)
	Begin
	Set @FirstTopLoads = 0
	Set @SecondTopLoads = 0
	Set @ThirdTopLoads = 0
	Set @LightLoads = Round(@TotalLoads*@LightCloseoutPercent/(@LightCloseoutPercent+@HeavyCloseoutPercent),0)
	Set @HeavyLoads = @TotalLoads-@FirstTopLoads-@SecondTopLoads-@ThirdTopLoads-@LightLoads
	End


--------------
--First Tops
--------------

--Two checks, the first is if First Top Loads are already in the system, go to Second Tops
--Or if the strategy has zero percent First Tops go to Second Tops
If @MaxExistingMarketSaleTypeID >= 10 GoTo Second_Tops
If @FirstTopPercent = 0 GoTo Second_Tops

While @CurrentAverageWeight < @FirstTopWeight
	Begin
	Set @CurrentAverageWeight = @CurrentAverageWeight
		--Growth Per Day
		+(Select ADG From  dbo.cft_FINISHING_ADG_WEEKLY Where WeekNumber = DatePart(wk,@DateTracker))
	Set @DateTracker = DateAdd(dd,1,@DateTracker)
	End
	
While @FirstTopLoads > 0
	Begin
	Insert Into @MarketLoad
			
	Select 'Top','LoadID',@PigGroupID,@BarnNumber,'Projected'
		,@DateTracker
		,@TopPacker
		,Ceiling(@TargetTopWeight/5)*5
		,Null,Null
		,Ceiling(@AverageLoadWeight/@TargetTopWeight) As PigsPerLoad

	Set @FirstTopLoads = @FirstTopLoads-1
	End


Second_Tops:
---------------
--Second Tops
---------------
If @MaxExistingMarketSaleTypeID >= 20 GoTo Third_Tops
If @SecondTopPercent = 0 GoTo Third_Tops

While @CurrentAverageWeight < @SecondTopWeight
	Begin
	Set @CurrentAverageWeight = @CurrentAverageWeight
		--Growth Per Day
		+(Select ADG From  dbo.cft_FINISHING_ADG_WEEKLY Where WeekNumber = DatePart(wk,@DateTracker))
	Set @DateTracker = DateAdd(dd,1,@DateTracker)
	End
	
While @SecondTopLoads > 0
	Begin
	Insert Into @MarketLoad
			
	Select 'Top','LoadID',@PigGroupID,@BarnNumber,'Projected'
		,@DateTracker
		,@TopPacker
		,Ceiling(@TargetTopWeight/5)*5
		,Null,Null
		,Ceiling(@AverageLoadWeight/@TargetTopWeight) As PigsPerLoad

	Set @SecondTopLoads = @SecondTopLoads-1
	End

Third_Tops:
---------------
--Third Tops
---------------
If @MaxExistingMarketSaleTypeID >= 25 GoTo Closeout
If @ThirdTopPercent = 0 GoTo Closeout

While @CurrentAverageWeight < @ThirdTopWeight
	Begin
	Set @CurrentAverageWeight = @CurrentAverageWeight
		--Growth Per Day
		+(Select ADG From  dbo.cft_FINISHING_ADG_WEEKLY Where WeekNumber = DatePart(wk,@DateTracker))
	Set @DateTracker = DateAdd(dd,1,@DateTracker)
	End
	
While @ThirdTopLoads > 0
	Begin
	Insert Into @MarketLoad
			
	Select 'Top','LoadID',@PigGroupID,@BarnNumber,'Projected'
		,@DateTracker
		,@TopPacker
		,Ceiling(@TargetTopWeight/5)*5
		,Null,Null
		,Ceiling(@AverageLoadWeight/@TargetTopWeight) As PigsPerLoad

	Set @ThirdTopLoads = @ThirdTopLoads-1
	End
	
Closeout:
------------------
--Closeout Loads
------------------

If @MaxExistingMarketSaleTypeID = 30 GoTo Results

While @CurrentAverageWeight < @TargetCloseoutWeight
	Begin
	Set @CurrentAverageWeight = @CurrentAverageWeight
		--Growth Per Day
		+(Select ADG From  dbo.cft_FINISHING_ADG_WEEKLY Where WeekNumber = DatePart(wk,@DateTracker))
	Set @DateTracker = DateAdd(dd,1,@DateTracker)
	End
	
While @HeavyLoads > 0
	Begin
	Insert Into @MarketLoad
	Select 'Closeout','LoadID',@PigGroupID,@BarnNumber,'Projected'
	,@DateTracker
	,@HeavyPacker
	,(Floor(@CurrentAverageWeight/5))*5+10
	,Null,Null
	,Ceiling(@AverageLoadWeight/((Floor(@CurrentAverageWeight/5))*5+10)) As PigsPerLoad
	Set @HeavyLoads = @HeavyLoads-1
	End

While @LightLoads > 0
	Begin
	Insert Into @MarketLoad
	Select 'Closeout','LoadID',@PigGroupID,@BarnNumber,'Projected'
	,@DateTracker
	,@LightPacker
	,(Floor(@CurrentAverageWeight/5))*5-5
	,Null,Null
	,Ceiling(@AverageLoadWeight/((Floor(@CurrentAverageWeight/5))*5-5)) As PigsPerLoad
	Set @LightLoads = @LightLoads-1
	End


Results:
	
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

From @MarketLoad

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DATA_MARKETING_SITE_PLAN_MARKET_LOAD_DETAIL] TO [db_sp_exec]
    AS [dbo];


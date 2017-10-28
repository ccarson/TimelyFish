-- =============================================
-- Author:		Matt Brandt
-- Create date: 01/11/2011
-- Description:	This procedure produces the actual or recommended market loads for a given PigGroupID.
-- =============================================
CREATE PROCEDURE dbo.cfp_DATA_MARKETING_PLAN_TRIUMPH_SINGLE_TOP 
	@PigGroupID Char(6) 
	, @CurrentInventory Float
	, @CurrentAverageWeight Float
	, @BarnNumber Int
	, @FillStartDate datetime
	, @EstStartWeight Float

AS
BEGIN

SET NOCOUNT ON;

--Declare the Results Table
Declare @MarketLoad Table
(LoadType Char(10)
, LoadID Char(10)
, PigGroupID Char(10)
, BarnNumber Char(6)
, LoadStatus Char(10)
, MovementDate datetime
, Destination Char(10)
, SystemDerivedAverageWeight Float
, EstimatedAverageWeight Float
, ActualAverageWeight Float)

Declare @TargetTopWeight Float
Declare @TargetCloseoutWeight Float
Declare @GrowthDaysToCloseout Int
Declare @GrowthDaysToFirstTop Int
Declare @AverageLoadWeight Float
Declare @TotalLoads Float
Declare @TotalTopLoads Float
Declare @TotalFirstTopLoads Float
Declare @FirstTopLoads Float
Declare @LightLoads Int
Declare @HeavyLoads Int

Select @TargetTopWeight = TargetToppingWeight From  dbo.cft_PACKER_YIELD_ASSUMPTIONS Where Packer = 'Triumph'
Select @TargetCloseoutWeight = TargetCloseoutWeight From  dbo.cft_PACKER_YIELD_ASSUMPTIONS Where Packer = 'Triumph'
Set @AverageLoadWeight = 47000
Set @TotalLoads = Floor(@TargetCloseoutWeight*@CurrentInventory/@AverageLoadWeight)

Declare @MaxExistingMarketSaleTypeID Int
Select @MaxExistingMarketSaleTypeID = IsNull(Max(Cast(pm.MarketSaleTypeID As Int)),0)
	From [$(SolomonApp)].dbo.cftPM pm 
	Where @PigGroupID = pm.SourcePigGroupID
		And pm.MarketSaleTypeID Between 10 And 30

----------------------------------------------------
--Insert Any Loads that Exist into the Results Table
----------------------------------------------------

Insert Into @MarketLoad
	
Select Case When pm.MarketSaleTypeID = 30 Then 'Closeout' Else 'Top' End As LoadType
, pm.PMLoadID as LoadID
, @PigGroupID
, @BarnNumber
, Case When pm.MovementDate < GetDate() Then 'Shipped' Else 'Scheduled' End As LoadStatus
, pm.MovementDate as MovementDate
, ps.Destination
,  dbo.cffn_GROWTH_CURVE_CALCULATOR(@CurrentAverageWeight,DateDiff(dd,DateAdd(dd,DateDiff(dd,0,GetDate()),0),pm.MovementDate)) as SystemDerivedAverageWeight
, Cast(pm.EstimatedWgt As Int) as EstimatedAverageWeight
, ps.ActualAverageWeight as ActualAverageWeight

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

-----------------------------------------
--Add any loads that need to be projected
-----------------------------------------

If @MaxExistingMarketSaleTypeID In(10,20,25)
	Begin
	
	Set @FirstTopLoads = 0
	--Project Closeouts
	Set @GrowthDaysToCloseout = Case When @TargetCloseoutWeight <= @CurrentAverageWeight Then 0
		Else	(Select Top 1 PigDay 
			From  dbo.cft_GROWTH_AND_FEED_CONSUMPTION_CURVE
			Where PigWeight >= @TargetCloseoutWeight
			Order By PigDay)
			-
			(Select Top 1 PigDay 
			From  dbo.cft_GROWTH_AND_FEED_CONSUMPTION_CURVE
			Where PigWeight >= @CurrentAverageWeight
			Order By PigDay)
		End
	
	Set @CurrentAverageWeight =  dbo.cffn_GROWTH_CURVE_CALCULATOR(@CurrentAverageWeight,@GrowthDaysToCloseout)

	Select @LightLoads = Ceiling(@TotalLoads*.3)
	Select @HeavyLoads = @TotalLoads-@LightLoads

	While @HeavyLoads > 0
		Begin
		Insert Into @MarketLoad
		Select 'Closeout','LoadID',@PigGroupID,@BarnNumber,'Projected'
		,DateAdd(dd,(@GrowthDaysToCloseout),DateAdd(dd,DateDiff(dd,0,GetDate()),0))
		,'Triumph',(Floor(@CurrentAverageWeight/5))*5+15,Null,Null
		Set @HeavyLoads = @HeavyLoads-1
		End

	While @LightLoads > 0
		Begin
		Insert Into @MarketLoad
		Select 'Closeout','LoadID',@PigGroupID,@BarnNumber,'Projected'
		,DateAdd(dd,@GrowthDaysToCloseout,DateAdd(dd,DateDiff(dd,0,GetDate()),0))
		,'Triumph'
		,(Floor(@CurrentAverageWeight/5))*5-10,Null,Null
		Set @LightLoads = @LightLoads-1
		End
		
	End

If @MaxExistingMarketSaleTypeID = 0
	Begin
	
	--Project First Tops	
	Set @GrowthDaysToFirstTop = Case When @TargetTopWeight <= @CurrentAverageWeight Then 0
		Else (Select Top 1 PigDay 
				From  dbo.cft_GROWTH_AND_FEED_CONSUMPTION_CURVE
				Where PigWeight*1.10 >= @TargetTopWeight
				Order By PigDay)
			-
			(Select Top 1 PigDay 
				From  dbo.cft_GROWTH_AND_FEED_CONSUMPTION_CURVE
				Where PigWeight >= @CurrentAverageWeight
				Order By PigDay)
		End

	Set @CurrentAverageWeight =  dbo.cffn_GROWTH_CURVE_CALCULATOR(@CurrentAverageWeight,@GrowthDaysToFirstTop)
	Set @FirstTopLoads = Case When Floor(@TotalLoads*.2) < 1 Then 1 Else Floor(@TotalLoads*.2) End
	Set @TotalLoads = @TotalLoads-@FirstTopLoads
	
	While @FirstTopLoads > 0
		
		Begin
		
		Insert Into @MarketLoad
			
		Select 'Top','LoadID',@PigGroupID,@BarnNumber,'Projected'
			,DateAdd(dd,@GrowthDaysToFirstTop,DateAdd(dd,DateDiff(dd,0,GetDate()),0))
			,'Triumph'
			,Ceiling(@TargetTopWeight/5)*5
			,Null,Null

		Set @FirstTopLoads = @FirstTopLoads-1
		
		End
	
	--Project Closeouts
	Set @GrowthDaysToCloseout = Case When @TargetCloseoutWeight <= @CurrentAverageWeight Then 0
		Else	(Select Top 1 PigDay 
			From  dbo.cft_GROWTH_AND_FEED_CONSUMPTION_CURVE
			Where PigWeight >= @TargetCloseoutWeight
			Order By PigDay)
			-
			(Select Top 1 PigDay 
			From  dbo.cft_GROWTH_AND_FEED_CONSUMPTION_CURVE
			Where PigWeight >= @CurrentAverageWeight
			Order By PigDay)
		End
	
	Set @CurrentAverageWeight =  dbo.cffn_GROWTH_CURVE_CALCULATOR(@CurrentAverageWeight,@GrowthDaysToCloseout)
	Set @LightLoads = Ceiling(@TotalLoads*.3)
	Set @HeavyLoads = @TotalLoads-@LightLoads

	While @HeavyLoads > 0
		Begin
		Insert Into @MarketLoad
		Select 'Closeout','LoadID',@PigGroupID,@BarnNumber,'Projected'
		,DateAdd(dd,(@GrowthDaysToFirstTop+@GrowthDaysToCloseout),DateAdd(dd,DateDiff(dd,0,GetDate()),0))
		,'Triumph',(Floor(@CurrentAverageWeight/5))*5+15,Null,Null
		Set @HeavyLoads = @HeavyLoads-1
		End

	While @LightLoads > 0
		Begin
		Insert Into @MarketLoad
		Select 'Closeout','LoadID',@PigGroupID,@BarnNumber,'Projected'
		,DateAdd(dd,@GrowthDaysToFirstTop+@GrowthDaysToCloseout,DateAdd(dd,DateDiff(dd,0,GetDate()),0))
		,'Triumph'
		,(Floor(@CurrentAverageWeight/5))*5-10,Null,Null
		Set @LightLoads = @LightLoads-1
		End
	
	End	
	
------------------------------------
--Process Results
------------------------------------

	
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

From @MarketLoad

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DATA_MARKETING_PLAN_TRIUMPH_SINGLE_TOP] TO [db_sp_exec]
    AS [dbo];


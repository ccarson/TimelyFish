

-- =============================================
-- Author:		Matt Brandt
-- Create date: 08/17/2010
-- Description:	This procedure creates the primary dataset for the Average Market Load Weight Report
--	            in the Transportation folder.
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_AVERAGE_MARKET_LOAD_WEIGHT]
	@ReportDate Datetime = Null

AS
BEGIN

SET NOCOUNT ON;

----------------------------
--Declare Target Load Weight
----------------------------

Declare @TargetLoadWeight Float
Set @TargetLoadWeight = 47000

---------------
--Declare Dates
---------------

Declare @EndDate Datetime
Declare @WeekStartDate Datetime
Declare @28DayStartDate Datetime
Declare @52WeekStartDate Datetime

Set @ReportDate = Case When @ReportDate Is Null Then GetDate() Else @ReportDate End
Set @EndDate = Case When Datepart(dw,@ReportDate) In (4,5,6,7) Then Dateadd(dd,-2,Dateadd(wk,Datediff(wk,0,@ReportDate),0))
	Else Dateadd(dd,-9,Dateadd(wk,Datediff(wk,0,@ReportDate),0)) End
Set @WeekStartDate = Dateadd(dd,-6,@EndDate)
Set @28DayStartDate = Dateadd(dd,-21,@WeekStartDate)
Set @52WeekStartDate = Dateadd(wk,-51,@WeekStartDate)


-------------------------------------
--Create Marketing Manager Temp Table
-------------------------------------

Declare @BaseManager Table
(ID Int Identity(1,1), SiteContactID Int, MarketSvcMgrContactID Int, EffectiveDate smalldatetime)

Insert Into @BaseManager

Select SiteContactID, MarketSvcMgrContactID, EffectiveDate
From CentralData.dbo.MarketSvcMgrAssignment
Order By SiteContactID, EffectiveDate

Declare @MarketServiceManager Table
(ID Int, SiteContactID Int, MarketSvcMgrContactID Int, StartDate smalldatetime, EndDate smalldatetime)

Insert Into @MarketServiceManager

Select ID, SiteContactID, MarketSvcMgrContactID, EffectiveDate As StartDate, Null As EndDate
From @BaseManager

Update m
Set EndDate = Case 
	When m.SiteContactID = (Select m1.SiteContactID From @MarketServiceManager m1 Where m1.ID = (m.ID+1)) 
		Then DateAdd(dd,-1,(Select m2.StartDate From @MarketServiceManager m2 Where m2.ID = (m.ID+1))) 
	Else GetDate()+1 End
From @MarketServiceManager m



-----------------------------
--Find Transport Transactions
-----------------------------

Declare @Transport Table
(PMLoadID Char(10), MovementDate SmallDateTime, BatNbr Char(10), RefNbr Char(10)
, SourceContactID Char(10)
, DeliveryWeight Float, Packer Char(20), MarketTransaction Int, DeadOnTruck Float, DeadInYard Float, TotalDetailQuantity Float
, TruckExpense Float
, Trucker Char(50))

Insert Into @Transport

Select pm.PMLoadID, pm.MovementDate, ps.BatNbr, ps.RefNbr
, (Select Top 1 p.SourceContactID From SolomonApp.dbo.cftPM p Where p.PMLoadID = pm.PMLoadID Order By p.ActualQty Desc) As SourceContactID
, Null AS DeliveryWeight
, Case When ps.CustId Like('%TriFoo%') Then 'Triumph'
		When ps.CustId = 'Tys' Then 'Tyson'
		When ps.CustId = 'Swift' Then 'Swift'
		Else 'Other' End As Packer
, Sum(Case When pm.TranSubTypeID IN('FM','WM') Then 1 Else 0 End) As MarketTransaction
, Null, Null, Null
, Sum(ps.AmtTruck) AS TruckExpense
, pm.TruckerContactID As Trucker
From SolomonApp.dbo.cftPM pm
	Left Join SolomonApp.dbo.cfvPIGSALEREV ps on pm.PMLoadId = ps.PMLoadID

Where pm.MovementDate >= @52WeekStartDate
	And pm.MovementDate <= @EndDate

Group By pm.PMLoadID, pm.MovementDate, ps.BatNbr, ps.RefNbr
	, Case When ps.CustId Like('%TriFoo%') Then 'Triumph'
		When ps.CustId = 'Tys' Then 'Tyson'
		When ps.CustId = 'Swift' Then 'Swift'
		Else 'Other' End
	, pm.TruckerContactID
		
Update t
Set DeadOnTruck = (Select Sum(Case When det.DetailTypeId = 'DT' Then det.Qty Else 0 End) 
	From SolomonApp.dbo.cftPSDetail det 
	Where t.BatNbr = det.BatNbr AND t.RefNbr = det.RefNbr
--	Group By t.PMLoadID
-- 2012/06/28 smr 
--Msg 164, Level 15, State 1, Line 97 Each GROUP BY expression must contain at least one column that is not an outer reference.
	)
, DeadInYard = (Select Sum(Case When det.DetailTypeId = 'DY' Then det.Qty Else 0 End) 
	From SolomonApp.dbo.cftPSDetail det 
	Where t.BatNbr = det.BatNbr AND t.RefNbr = det.RefNbr
--	Group By t.PMLoadID
-- 2012/06/28 smr 
--Msg 164, Level 15, State 1, Line 97 Each GROUP BY expression must contain at least one column that is not an outer reference.
	)
, TotalDetailQuantity = (Select Sum(det.Qty) 
	From SolomonApp.dbo.cftPSDetail det 
	Where t.BatNbr = det.BatNbr AND t.RefNbr = det.RefNbr
--	Group By t.PMLoadID
-- 2012/06/28 smr 
--Msg 164, Level 15, State 1, Line 97 Each GROUP BY expression must contain at least one column that is not an outer reference.
	)
, DeliveryWeight = (Select Sum(Case When det.WgtLive < 10 Then det.Qty*200 
		When det.WgtLive Is Null Then det.Qty*200 Else det.WgtLive End)
	From SolomonApp.dbo.cftPSDetail det 
	Where t.BatNbr = det.BatNbr AND t.RefNbr = det.RefNbr
--	Group By t.PMLoadID
-- 2012/06/28 smr 
--Msg 164, Level 15, State 1, Line 97 Each GROUP BY expression must contain at least one column that is not an outer reference.
	)
From @Transport t

Update t
Set Trucker = RTrim(c.ContactName)
From @Transport t
	Left Join SolomonApp.dbo.cftContact c On t.Trucker = c.ContactID 

Delete From @Transport Where DeliveryWeight Is Null

--Select * From @Transport

-------------------------------------------------
--Organize Transportation Transactions into Loads
-------------------------------------------------

Declare @Load Table
(PMLoadID Char(10)
, MovementDate SmallDateTime
, Trucker Char(50)
, Packer Char(20)
, MarketTransaction Int
, TotalWeight Float
, DeadOnTruck Float
, DeadInYard Float
, TotalQuantity Float
, AveragePigWeight Float
, TruckExpense Float
, SourceContactID Char(10)
, MarketingManager Char(50))

Insert Into @Load

Select PMLoadID, MovementDate
, Trucker
, Packer
, Sum(MarketTransaction) As MarketTransaction
, Sum(DeliveryWeight) As TotalWeight
, Sum(DeadOnTruck) As DeadOnTruck
, Sum(DeadInYard) As DeadInYard
, Sum(TotalDetailQuantity) As TotalQuantity
, Null
, Sum(TruckExpense) AS TruckExpense
, SourceContactID
, Null
From @Transport

Group By PMLoadID, MovementDate, Trucker, Packer, SourceContactID
Order By TotalWeight

Delete From @Load Where MarketTransaction < 1

Delete From @Load Where TotalWeight < 36000

Update l
Set AveragePigWeight = TotalWeight/TotalQuantity
From @Load l

Update l
Set l.MarketingManager = m.MarketSvcMgrContactID
From @Load l
	Inner Join @MarketServiceManager m On Cast(l.SourceContactID As Int) = m.SiteContactID
Where l.MovementDate Between m.StartDate And m.EndDate

Update l
Set l.MarketingManager = c.ContactName
From @Load l
	Inner Join SolomonApp.dbo.cftContact c On l.MarketingManager = Cast(c.ContactID As Int)
	
--Select * From @Load


----------------------------------
--Compile the Results Table
----------------------------------


Declare @Results Table
(RowRank Int, Packer Char(50), ReportDate DateTime, Loads Int
, Under46 Float, o46to48 Float, o48to50 Float, Over50 Float
, AverageWeight Float, PercentDoTDiY Float
, CostPerLoad Money, CostPerCWeight Money, EconomicOpportunity Money
, AveragePigWeight Float, AveragePigsPerLoad Float)

Insert Into @Results

----------------------------
--Last 7 days by Packer
----------------------------

Select 1, Packer, Null
, Count(*) as Loads
, Avg(Case When TotalWeight < 46000 Then 1.00 Else 0 End) As Under46
, Avg(Case When TotalWeight Between 46000 And 47999 Then 1.00 Else 0 End) As o46to48
, Avg(Case When TotalWeight Between 48000 And 49999 Then 1.00 Else 0 End) As o48to50
, Avg(Case When TotalWeight >= 50000 Then 1.00 Else 0 End) As Over50
, Avg(TotalWeight) As AverageWeight
, (Sum(DeadOnTruck)+Sum(DeadInYard))/Sum(TotalQuantity) As PercentDoTDiY
, Avg(TruckExpense) As CostPerLoad
, Sum(TruckExpense)/Sum(TotalWeight)*100 As CostPerCWeight
, Floor(Sum(Case When TotalWeight > @TargetLoadWeight Then 0 Else @TargetLoadWeight-TotalWeight End)/@TargetLoadWeight)*Avg(TruckExpense) As EconomicOpportunity
, Null, Null

From @Load
Where MovementDate Between @WeekStartDate And @EndDate
Group By Packer

Insert Into @Results

---------------------------------
--Last 7 Days Companywide
---------------------------------

Select 2, 'Total', Null
, Count(*) as Loads
, Avg(Case When TotalWeight < 46000 Then 1.00 Else 0 End) As Under46
, Avg(Case When TotalWeight Between 46000 And 47999 Then 1.00 Else 0 End) As o46to48
, Avg(Case When TotalWeight Between 48000 And 49999 Then 1.00 Else 0 End) As o48to50
, Avg(Case When TotalWeight >= 50000 Then 1.00 Else 0 End) As Over50
, Avg(TotalWeight) As AverageWeight
, (Sum(DeadOnTruck)+Sum(DeadInYard))/Sum(TotalQuantity) As PercentDoTDiY
, Avg(TruckExpense) As CostPerLoad
, Sum(TruckExpense)/Sum(TotalWeight)*100 As CostPerCWeight
, Null, Null, Null

From @Load
Where MovementDate Between @WeekStartDate And @EndDate

Update r
Set EconomicOpportunity = (Select Sum(EconomicOpportunity) From @Results)
From @Results r
Where r.RowRank = 2

Insert Into @Results

----------------------------
--Last 28 days by Packer
----------------------------

Select 3, Packer, Null
, Count(*) as Loads
, Avg(Case When TotalWeight < 46000 Then 1.00 Else 0 End) As Under46
, Avg(Case When TotalWeight Between 46000 And 47999 Then 1.00 Else 0 End) As o46to48
, Avg(Case When TotalWeight Between 48000 And 49999 Then 1.00 Else 0 End) As o48to50
, Avg(Case When TotalWeight >= 50000 Then 1.00 Else 0 End) As Over50
, Avg(TotalWeight) As AverageWeight
, (Sum(DeadOnTruck)+Sum(DeadInYard))/Sum(TotalQuantity) As PercentDoTDiY
, Avg(TruckExpense) As CostPerLoad
, Sum(TruckExpense)/Sum(TotalWeight)*100 As CostPerCWeight
, Floor(Sum(Case When TotalWeight > @TargetLoadWeight Then 0 Else @TargetLoadWeight-TotalWeight End)/@TargetLoadWeight)*Avg(TruckExpense) As EconomicOpportunity
, Null, Null

From @Load
Where MovementDate Between @28DayStartDate And @EndDate
Group By Packer

Insert Into @Results

---------------------------------
--Last 28 Days Companywide
---------------------------------

Select 4, 'Total', Null
, Count(*) as Loads
, Avg(Case When TotalWeight < 46000 Then 1.00 Else 0 End) As Under46
, Avg(Case When TotalWeight Between 46000 And 47999 Then 1.00 Else 0 End) As o46to48
, Avg(Case When TotalWeight Between 48000 And 49999 Then 1.00 Else 0 End) As o48to50
, Avg(Case When TotalWeight >= 50000 Then 1.00 Else 0 End) As Over50
, Avg(TotalWeight) As AverageWeight
, (Sum(DeadOnTruck)+Sum(DeadInYard))/Sum(TotalQuantity) As PercentDoTDiY
, Avg(TruckExpense) As CostPerLoad
, Sum(TruckExpense)/Sum(TotalWeight)*100 As CostPerCWeight
, Null, Null, Null

From @Load
Where MovementDate Between @28DayStartDate And @EndDate

Update r
Set EconomicOpportunity = (Select Sum(EconomicOpportunity) From @Results Where RowRank = 3)
From @Results r
Where r.RowRank = 4

Insert Into @Results

-----------------------------
--Weekly by Packer
-----------------------------

Select 11, Rtrim(Packer) As Packer, DateAdd(wk,DateDiff(wk,0,MovementDate),0) As ReportDate
, Count(*) as Loads
, Avg(Case When TotalWeight < 46000 Then 1.00 Else 0 End) As Under46
, Avg(Case When TotalWeight Between 46000 And 47999 Then 1.00 Else 0 End) As o46to48
, Avg(Case When TotalWeight Between 48000 And 49999 Then 1.00 Else 0 End) As o48to50
, Avg(Case When TotalWeight >= 50000 Then 1.00 Else 0 End) As Over50
, Avg(TotalWeight) As AverageWeight
, (Sum(DeadOnTruck)+Sum(DeadInYard))/Sum(TotalQuantity) As PercentDoTDiY
, Avg(TruckExpense) As CostPerLoad
, Sum(TruckExpense)/Sum(TotalWeight)*100 As CostPerCWeight
, Null
, Null
, Null

From @Load
Group By RTrim(Packer), DateAdd(wk,DateDiff(wk,0,MovementDate),0)

------------------------
--Companywide Weekly
------------------------

Insert Into @Results

Select 12, 'Total', DateAdd(wk,DateDiff(wk,0,MovementDate),0) As ReportDate
, Count(*) as Loads
, Avg(Case When TotalWeight < 46000 Then 1.00 Else 0 End) As Under46
, Avg(Case When TotalWeight Between 46000 And 47999 Then 1.00 Else 0 End) As o46to48
, Avg(Case When TotalWeight Between 48000 And 49999 Then 1.00 Else 0 End) As o48to50
, Avg(Case When TotalWeight >= 50000 Then 1.00 Else 0 End) As Over50
, Avg(TotalWeight) As AverageWeight
, (Sum(DeadOnTruck)+Sum(DeadInYard))/Sum(TotalQuantity) As PercentDoTDiY
, Avg(TruckExpense) As CostPerLoad
, Sum(TruckExpense)/Sum(TotalWeight)*100 As CostPerCWeight
, Null
, Null
, Null

From @Load
Group By DateAdd(wk,DateDiff(wk,0,MovementDate),0)


---------------------------------
--Under 46 DoTDiYChart
---------------------------------

Insert Into @Results

Select 43, RTrim(Packer) As Packer, DateAdd(wk,DateDiff(wk,0,MovementDate),0) As ReportDate
, Null, Null, Null, Null, Null, Null
, (Sum(DeadOnTruck)+Sum(DeadInYard))/Sum(TotalQuantity) As PercentDoTDiY
, Null, Null, Null, Null, Null

From @Load
Where TotalWeight < 46000
Group By RTrim(Packer), DateAdd(wk,DateDiff(wk,0,MovementDate),0)

Insert Into @Results

Select 43, 'Total' As Packer, DateAdd(wk,DateDiff(wk,0,MovementDate),0) As ReportDate
, Null, Null, Null, Null, Null, Null
, (Sum(DeadOnTruck)+Sum(DeadInYard))/Sum(TotalQuantity) As PercentDoTDiY
, Null, Null, Null, Null, Null
From @Load
Where TotalWeight < 46000
Group By DateAdd(wk,DateDiff(wk,0,MovementDate),0)

---------------------------------
--Between 46-48 DoTDiYChart
---------------------------------

Insert Into @Results

Select 45, RTrim(Packer) As Packer, DateAdd(wk,DateDiff(wk,0,MovementDate),0) As ReportDate
, Null, Null, Null, Null, Null, Null
, (Sum(DeadOnTruck)+Sum(DeadInYard))/Sum(TotalQuantity) As PercentDoTDiY
, Null, Null, Null, Null, Null
From @Load
Where TotalWeight Between 46000 And 47999
Group By RTrim(Packer), DateAdd(wk,DateDiff(wk,0,MovementDate),0)

Insert Into @Results

Select 45, 'Total' As Packer, DateAdd(wk,DateDiff(wk,0,MovementDate),0) As ReportDate
, Null, Null, Null, Null, Null, Null
, (Sum(DeadOnTruck)+Sum(DeadInYard))/Sum(TotalQuantity) As PercentDoTDiY
, Null, Null, Null, Null, Null

From @Load
Where TotalWeight Between 46000 And 47999
Group By DateAdd(wk,DateDiff(wk,0,MovementDate),0)

---------------------------------
--Between 48-50 DoTDiYChart
---------------------------------

Insert Into @Results

Select 47, RTrim(Packer) As Packer, DateAdd(wk,DateDiff(wk,0,MovementDate),0) As ReportDate
, Null, Null, Null, Null, Null, Null
, (Sum(DeadOnTruck)+Sum(DeadInYard))/Sum(TotalQuantity) As PercentDoTDiY
, Null, Null, Null, Null, Null

From @Load
Where TotalWeight Between 48000 And 49999
Group By RTrim(Packer), DateAdd(wk,DateDiff(wk,0,MovementDate),0)

Insert Into @Results

Select 47, 'Total' As Packer, DateAdd(wk,DateDiff(wk,0,MovementDate),0) As ReportDate
, Null, Null, Null, Null, Null, Null
, (Sum(DeadOnTruck)+Sum(DeadInYard))/Sum(TotalQuantity) As PercentDoTDiY
, Null, Null, Null, Null, Null
From @Load
Where TotalWeight Between 48000 And 49999
Group By DateAdd(wk,DateDiff(wk,0,MovementDate),0)

---------------------------------
--Over 50 DoTDiYChart
---------------------------------

Insert Into @Results

Select 48, RTrim(Packer) As Packer, DateAdd(wk,DateDiff(wk,0,MovementDate),0) As ReportDate
, Null, Null, Null, Null, Null, Null
, (Sum(DeadOnTruck)+Sum(DeadInYard))/Sum(TotalQuantity) As PercentDoTDiY
, Null, Null, Null, Null, Null
From @Load
Where TotalWeight >= 50000
Group By RTrim(Packer), DateAdd(wk,DateDiff(wk,0,MovementDate),0)

Insert Into @Results

Select 48, 'Total' As Packer, DateAdd(wk,DateDiff(wk,0,MovementDate),0) As ReportDate
, Null, Null, Null, Null, Null, Null
, (Sum(DeadOnTruck)+Sum(DeadInYard))/Sum(TotalQuantity) As PercentDoTDiY
, Null, Null, Null, Null, Null
From @Load
Where TotalWeight >= 50000
Group By DateAdd(wk,DateDiff(wk,0,MovementDate),0)

Insert Into @Results

----------------------------
--Last 7 days by Marketing Manager
----------------------------

Select 71, MarketingManager As Packer, Null
, Count(*) as Loads
, Avg(Case When TotalWeight < 46000 Then 1.00 Else 0 End) As Under46
, Avg(Case When TotalWeight Between 46000 And 47999 Then 1.00 Else 0 End) As o46to48
, Avg(Case When TotalWeight Between 48000 And 49999 Then 1.00 Else 0 End) As o48to50
, Avg(Case When TotalWeight >= 50000 Then 1.00 Else 0 End) As Over50
, Avg(TotalWeight) As AverageWeight
, (Sum(DeadOnTruck)+Sum(DeadInYard))/Sum(TotalQuantity) As PercentDoTDiY
, Avg(TruckExpense) As CostPerLoad
, Sum(TruckExpense)/Sum(TotalWeight)*100 As CostPerCWeight
, Floor(Sum(Case When TotalWeight > @TargetLoadWeight Then 0 Else @TargetLoadWeight-TotalWeight End)/@TargetLoadWeight)*Avg(TruckExpense) As EconomicOpportunity
, Avg(AveragePigWeight) As AveragePigWeight
, Avg(TotalQuantity) As AveragePigsPerLoad

From @Load
Where MovementDate Between @WeekStartDate And @EndDate
Group By MarketingManager

Insert Into @Results

----------------------------
--Last 7 days by Trucker
----------------------------

Select 81, Trucker As Packer, Null
, Count(*) as Loads
, Avg(Case When TotalWeight < 46000 Then 1.00 Else 0 End) As Under46
, Avg(Case When TotalWeight Between 46000 And 47999 Then 1.00 Else 0 End) As o46to48
, Avg(Case When TotalWeight Between 48000 And 49999 Then 1.00 Else 0 End) As o48to50
, Avg(Case When TotalWeight >= 50000 Then 1.00 Else 0 End) As Over50
, Avg(TotalWeight) As AverageWeight
, (Sum(DeadOnTruck)+Sum(DeadInYard))/Sum(TotalQuantity) As PercentDoTDiY
, Avg(TruckExpense) As CostPerLoad
, Sum(TruckExpense)/Sum(TotalWeight)*100 As CostPerCWeight
, Floor(Sum(Case When TotalWeight > @TargetLoadWeight Then 0 Else @TargetLoadWeight-TotalWeight End)/@TargetLoadWeight)*Avg(TruckExpense) As EconomicOpportunity
, Avg(AveragePigWeight) As AveragePigWeight
, Avg(TotalQuantity) As AveragePigsPerLoad

From @Load
Where MovementDate Between @WeekStartDate And @EndDate
Group By Trucker

--------------------
--------------------

Select *
From @Results

END



-- =============================================
-- Author:		Matt Brandt
-- Create date: 12/03/2010
-- Description:	
-- =============================================
CREATE PROCEDURE dbo.cfp_DATA_AVERAGE_MARKET_LOAD_WEIGHT
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


-----------------------------
--Find Transport Transactions
-----------------------------

Declare @Transport Table
(PMLoadID Char(10), MovementDate SmallDateTime, BatNbr Char(10), RefNbr Char(10)
, DeliveryWeight Float, Packer Char(20), MarketTransaction Int, DeadOnTruck Float, DeadInYard Float, TotalDetailQuantity Float
, TruckExpense Float
, Trucker Char(50))

Insert Into @Transport

Select pm.PMLoadID, pm.MovementDate, ps.BatNbr, ps.RefNbr
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
	Group By t.PMLoadID)
, DeadInYard = (Select Sum(Case When det.DetailTypeId = 'DY' Then det.Qty Else 0 End) 
	From SolomonApp.dbo.cftPSDetail det 
	Where t.BatNbr = det.BatNbr AND t.RefNbr = det.RefNbr
	Group By t.PMLoadID)
, TotalDetailQuantity = (Select Sum(det.Qty) 
	From SolomonApp.dbo.cftPSDetail det 
	Where t.BatNbr = det.BatNbr AND t.RefNbr = det.RefNbr
	Group By t.PMLoadID)
, DeliveryWeight = (Select Sum(Case When det.WgtLive < 10 Then det.Qty*200 
		When det.WgtLive Is Null Then det.Qty*200 Else det.WgtLive End)
	From SolomonApp.dbo.cftPSDetail det 
	Where t.BatNbr = det.BatNbr AND t.RefNbr = det.RefNbr
	Group By t.PMLoadID)
From @Transport t

Update t
Set Trucker = RTrim(c.ContactName)
From @Transport t
	Left Join SolomonApp.dbo.cftContact c On t.Trucker = c.ContactID 

Delete From @Transport Where DeliveryWeight Is Null

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
)

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

From @Transport

Group By PMLoadID, MovementDate, Trucker, Packer
Order By TotalWeight

Delete From @Load Where MarketTransaction < 1

Delete From @Load Where TotalWeight < 36000

Update l
Set AveragePigWeight = TotalWeight/TotalQuantity
From @Load l

-----------------------------
--Weekly by Packer
-----------------------------

Select DateAdd(wk,DateDiff(wk,0,MovementDate),0) As MovementWeek
, PMLoadID
, MovementDate
, TotalWeight
, DeadOnTruck As DoTs
, DeadInYard As DiYs
, TotalQuantity 
, Rtrim(Packer) As Packer

From @Load

Order By MovementWeek, Packer

END

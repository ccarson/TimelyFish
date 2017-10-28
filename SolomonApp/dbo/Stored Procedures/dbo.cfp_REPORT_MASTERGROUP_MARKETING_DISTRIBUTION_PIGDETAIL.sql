-- =============================================
-- Author:		Matt Brandt
-- Create date: 10/11/2010
-- Description:	This procedure makes the Pig Detail dataset for the Mastergroup Marketing Distribution report.
-- =============================================
CREATE PROCEDURE dbo.cfp_REPORT_MASTERGROUP_MARKETING_DISTRIBUTION_PIGDETAIL 
	-- Add the parameters for the stored procedure here
	@PigGroupID Char(6) 
AS
BEGIN

SET NOCOUNT ON;

------------------------------------------------------
--Build a Table with all of the groups to be processed
------------------------------------------------------

If Object_ID('#Mastergroup') Is Not Null
Drop Table #Mastergroup

Create Table #Mastergroup (ID Int Identity(1,1), PigGroupID Char(10))

Insert Into #Mastergroup

Select PigGroupID From SolomonApp.dbo.cftPigGroup Where CF03 = (Select CF03 From SolomonApp.dbo.cftPigGroup Where PigGroupID = @PigGroupID)

----------------------------------
----------------------------------

SET NOCOUNT ON;

Declare @TriumphYield Float
Declare @TysonYield Float
Declare @SwiftYield Float
Declare @Counter Int
Declare @End Int
Declare @CloseoutDate smalldatetime

Select @TriumphYield = Yield From SolomonApp_dw.dbo.cft_PACKER_YIELD_ASSUMPTIONS Where Packer = 'Triumph'
Select @TysonYield = Yield From SolomonApp_dw.dbo.cft_PACKER_YIELD_ASSUMPTIONS Where Packer = 'Tyson'
Select @SwiftYield = Yield From SolomonApp_dw.dbo.cft_PACKER_YIELD_ASSUMPTIONS Where Packer = 'Swift'
Set @Counter = 1
Select @End = Max(ID) From #Mastergroup

--Organize the Pig Sale table
Declare @PigSale Table
(KillDate smalldatetime
, PigGroupID char(10)
, CustID char(15)
, TattooNbr char(6)
, LoadType char(30)
)

--Organize the PigMovement table
Declare @PM Table
(MovementDate smalldatetime, TattooNbr char(6), LoadType char(50))


--Make a Pig Inventory Table
Declare @PigInv Table
(KillDate smalldatetime
, PigGroupID char(10)
, CustID char(15)
, LoadType char(10)
, TattooNbr char(6)
, MeasuredWeight Float
, AdjustedWeight Float
, Headcount Int
, CloseoutDate smalldatetime)

--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
While @Counter <= @End

Begin

--Pig Sale
Insert Into @PigSale

Select Distinct Min(KillDate) As KillDate
, ps.PigGroupID
, ps.CustId
, ps.TattooNbr
, Null

from SolomonApp.dbo.cfvPIGSALEREV ps
	Inner Join SolomonApp.dbo.cftContact c on c.ContactID=ps.PkrContactID

where ps.PigGroupID = (Select m.PigGroupID From #Mastergroup m Where m.ID = @Counter)
	and ps.SaleTypeID='MS'
	
Group By ps.CustId, ps.PigGroupID, ps.TattooNbr

Order By KillDate

--Pig Movement
Insert Into @PM

Select Distinct pm.MovementDate, ps.TattooNbr, RTrim(mst.Description) As LoadType

From SolomonApp.dbo.cfvPIGSALEREV ps 
	Inner Join SolomonApp.dbo.cftPM pm on pm.PMLoadId = ps.PMLoadID
	Inner Join SolomonApp.dbo.cftPigGroup pg on ps.PigGroupID = pg.PigGroupID
	Inner Join SolomonApp.dbo.cftMarketSaleType mst on pm.MarketSaleTypeID = mst.MarketSaleTypeID
			
Where ps.PigGroupID = (Select m.PigGroupID From #Mastergroup m Where m.ID = @Counter)

Order By pm.MovementDate

Update p
Set LoadType = (Select Top 1 m.LoadType
		From @PM m
		Where m.MovementDate >= DateAdd(d,-1,p.KillDate)
			And m.TattooNbr = p.TattooNbr
		Order By m.MovementDate)

From @PigSale p 

Update p
Set LoadType = 'Cull'
From @PigSale p
Where LoadType Is Null

Set @CloseoutDate = Case When Exists (Select KillDate From @PigSale Where LoadType = 'Closeout')
								Then (Select MIN(KillDate) From @PigSale Where LoadType = 'Closeout')
						Else (Select Max(KillDate) From @PigSale) End

--Triumph
Insert Into @PigInv

Select p.KillDate, p.PigGroupID, 'Triumph', p.LoadType, p.TattooNbr, d.HotWgt/@TriumphYield As MeasuredWeight
, Null
, Count(d.HotWgt) As Headcount
, @CloseoutDate As CloseoutDate

From @PigSale p
	Inner Join SolomonApp.dbo.cftPSDetTriumph d On p.KillDate = d.KillDate And p.TattooNbr = d.TattooNbr
	
Where p.CustID = 'TRIFOO' and d.AddDelete=''
	
Group By p.KillDate, p.PigGroupID, p.CustID, p.LoadType, p.TattooNbr, d.HotWgt

--Swift
Insert Into @PigInv

Select p.KillDate, p.PigGroupID, 'Swift', p.LoadType, p.TattooNbr, d.HotWeight/@SwiftYield As MeasuredWeight
, Null
, Count(d.HotWeight) As Headcount
, @CloseoutDate As CloseoutDate

From @PigSale p
	Inner Join SolomonApp.dbo.cftPSDetSwift d On p.KillDate = d.KillDate And p.TattooNbr = d.TattooNbr
	
Where p.CustID = 'SWIFT' and d.ExceptionCode = ' '
	
Group By p.KillDate, p.PigGroupID, p.CustID, p.LoadType, p.TattooNbr, d.HotWeight

--Tyson
Insert Into @PigInv

Select p.KillDate, p.PigGroupID, 'Tyson', p.LoadType, p.TattooNbr, (HotCarcassWeight/TotalHead)/@TysonYield As MeasuredWeight
, Null
, Cast(TotalHead As Int) As Headcount
, @CloseoutDate As CloseoutDate

From @PigSale p
	Inner Join SolomonApp.dbo.cftPSDetTyson d On p.KillDate = d.KillDate And p.TattooNbr = d.Tattoo
	
Where p.CustID = 'TYS'

Delete From @PigSale
Delete From @PM
Set @Counter = @Counter+1

End

Drop Table #Mastergroup

Update i
Set AdjustedWeight = Floor(SolomonApp_dw.dbo.cffn_GROWTH_CURVE_CALCULATOR(MeasuredWeight,DateDiff(d,KillDate,CloseoutDate))/10)*10
From @PigInv i

Update i
Set AdjustedWeight = Case When AdjustedWeight < 200 Then 200
	When AdjustedWeight > 360 Then 360
	Else AdjustedWeight End
From @PigInv i

Select RTrim(LoadType)+'-'+RTrim(CustID) As Category
, Case When LoadType = 'Top' Then 1
	When LoadType = '2nd Top' Then 2
	When LoadType = '3rd Top' Then 3
	When LoadType = 'Closeout' Then 4
	Else 5 End As CategoryRank
, AdjustedWeight
, Sum(Headcount) As Headcount
From @PigInv
Group By RTrim(LoadType)+'-'+RTrim(CustID)
, Case When LoadType = 'Top' Then 1
	When LoadType = '2nd Top' Then 2
	When LoadType = '3rd Top' Then 3
	When LoadType = 'Closeout' Then 4
	Else 5 End
, AdjustedWeight
Order By Category, AdjustedWeight
	
	
END

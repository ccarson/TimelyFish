-- =============================================
-- Author:		Matt Brandt
-- Create date: 01/06/2011
-- Description:	This procedure calculates the actual weight distribution and packer destinations for a given PigGroupID.
-- =============================================
CREATE PROCEDURE dbo.cfp_DATA_MARKETING_DISTRIBUTION_PIGGROUP 
	@PigGroupID Char(6) 

AS
BEGIN

SET NOCOUNT ON;

Declare @TriumphYield Float
Declare @TysonYield Float
Declare @SwiftYield Float
Declare @CloseoutDate smalldatetime

Select @TriumphYield = Yield From  dbo.cft_PACKER_YIELD_ASSUMPTIONS Where Packer = 'Triumph'
Select @TysonYield = Yield From  dbo.cft_PACKER_YIELD_ASSUMPTIONS Where Packer = 'Tyson'
Select @SwiftYield = Yield From  dbo.cft_PACKER_YIELD_ASSUMPTIONS Where Packer = 'Swift'

--Organize the Pig Sale table
Declare @PigSale Table
(KillDate smalldatetime
, PigGroupID char(10)
, Barn char(6)
, CustID char(15)
, TattooNbr char(6)
, LoadType char(30)
)

--Make a Pig Inventory Table
Declare @PigInv Table
(ID Int Identity(1,1)
, KillDate smalldatetime
, PigGroupID char(10)
, Barn char(6)
, CustID char(15)
, LoadType char(10)
, TattooNbr char(6)
, MeasuredWeight Float
, AdjustedWeight Float
, Headcount Int
, CloseoutDate smalldatetime)

--------------------------------------------------------------------------------------------------------
------------------------------------------------
--Pig Sale
------------------------------------------------

Insert Into @PigSale

Select Min(ps.KillDate) As KillDate
, ps.PigGroupID
, ps.BarnNbr As Barn
, ps.CustId
, ps.TattooNbr
, RTrim(mst.Description) As LoadType

From [$(SolomonApp)].dbo.cfvPIGSALEREV ps
	Inner Join [$(SolomonApp)].dbo.cftPM pm on pm.PMLoadId = ps.PMLoadID
	Inner Join [$(SolomonApp)].dbo.cftMarketSaleType mst on pm.MarketSaleTypeID = mst.MarketSaleTypeID
			
Where ps.PigGroupID = @PigGroupID
	And pm.MarketSaleTypeID In(10,20,25,30)

	
Group By ps.CustId, ps.PigGroupID, ps.BarnNbr, ps.TattooNbr, RTrim(mst.Description)

Order By ps.KillDate

Set @CloseoutDate = Case When Exists (Select KillDate From @PigSale Where LoadType = 'Closeout')
								Then (Select MIN(KillDate) From @PigSale Where LoadType = 'Closeout')
						Else (Select Max(KillDate) From @PigSale) End

--Triumph
Insert Into @PigInv

Select p.KillDate, p.PigGroupID, p.Barn, 'Triumph', p.LoadType, p.TattooNbr, d.HotWgt/@TriumphYield As MeasuredWeight
, Null
, Count(d.HotWgt) As Headcount
, @CloseoutDate As CloseoutDate

From @PigSale p
	Inner Join [$(SolomonApp)].dbo.cftPSDetTriumph d On p.KillDate = d.KillDate And p.TattooNbr = d.TattooNbr
	
Where p.CustID = 'TRIFOO' and d.AddDelete=''
	
Group By p.KillDate, p.PigGroupID, p.Barn, p.CustID, p.LoadType, p.TattooNbr, d.HotWgt

--Swift
Insert Into @PigInv

Select p.KillDate, p.PigGroupID, p.Barn, 'Swift', p.LoadType, p.TattooNbr, d.HotWeight/@SwiftYield As MeasuredWeight
, Null
, Count(d.HotWeight) As Headcount
, @CloseoutDate As CloseoutDate

From @PigSale p
	Inner Join [$(SolomonApp)].dbo.cftPSDetSwift d On p.KillDate = d.KillDate And p.TattooNbr = d.TattooNbr
	
Where p.CustID = 'SWIFT' and d.ExceptionCode = ' '
	
Group By p.KillDate, p.PigGroupID, p.Barn, p.CustID, p.LoadType, p.TattooNbr, d.HotWeight

--Tyson
Insert Into @PigInv

Select p.KillDate, p.PigGroupID, p.Barn, 'Tyson', p.LoadType, p.TattooNbr, (HotCarcassWeight/TotalHead)/@TysonYield As MeasuredWeight
, Null
, Cast(TotalHead As Int) As Headcount
, @CloseoutDate As CloseoutDate

From @PigSale p
	Inner Join [$(SolomonApp)].dbo.cftPSDetTyson d On p.KillDate = d.KillDate And p.TattooNbr = d.Tattoo
	
Where p.CustID = 'TYS'

Update i
Set AdjustedWeight = Floor( dbo.cffn_GROWTH_CURVE_CALCULATOR(MeasuredWeight,DateDiff(d,KillDate,CloseoutDate))/10)*10
From @PigInv i

Update i
Set AdjustedWeight = Case When AdjustedWeight < 180 Then 180
	When AdjustedWeight > 360 Then 360
	Else AdjustedWeight End
From @PigInv i

Declare @Results Table
(PigGroupID Char(10), Barn Char(6), Category Char(40), CategoryRank Int, AdjustedWeight Int, Headcount Int
, AvgWeightToPacker Float, CV Float)

Insert Into @Results

Select PigGroupID
, Barn
, RTrim(LoadType)+'-'+RTrim(CustID) As Category
, Case When LoadType = 'Top' Then 1
	When LoadType = '2nd Top' Then 2
	When LoadType = '3rd Top' Then 3
	When LoadType = 'Closeout' Then 4
	Else 5 End As CategoryRank
, AdjustedWeight
, Sum(Headcount) As Headcount
, Null
, Null
From @PigInv
Group By PigGroupID, Barn
, RTrim(LoadType)+'-'+RTrim(CustID)
, Case When LoadType = 'Top' Then 1
	When LoadType = '2nd Top' Then 2
	When LoadType = '3rd Top' Then 3
	When LoadType = 'Closeout' Then 4
	Else 5 End
, AdjustedWeight



-----------------------------------------------
--Average Weight and CV Calculations
-----------------------------------------------
Declare @Counter Int
Declare @CounterStop Int
Set @Counter = 1
Select @CounterStop = Max(ID) From @PigInv

Declare @PigList Table (CustID char(15), LoadType char(10), MeasuredWeight Float)

While @Counter <= @CounterStop
	Begin
	
	While (Select Headcount From @PigInv Where ID = @Counter) > 0
		Begin
		Insert Into @PigList
		Select CustID, LoadType, MeasuredWeight From @PigInv Where ID = @Counter
		
		Update i
		Set Headcount = Headcount-1
		From @PigInv i
		Where ID = @Counter
		End
	
	Set @Counter = @Counter+1
	
	End
	
Update r
Set AvgWeightToPacker = (Select Avg(pl.MeasuredWeight) From @PigList pl Where r.Category = RTrim(pl.LoadType)+'-'+RTrim(pl.CustID))
From @Results r
	
Update r
Set CV = (Select StDev(pl.MeasuredWeight)/Avg(pl.MeasuredWeight) From @PigList pl Where r.Category = RTrim(pl.LoadType)+'-'+RTrim(pl.CustID))
From @Results r

Delete From @Results Where AdjustedWeight Is Null

Select * From @Results

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_DATA_MARKETING_DISTRIBUTION_PIGGROUP] TO [db_sp_exec]
    AS [dbo];


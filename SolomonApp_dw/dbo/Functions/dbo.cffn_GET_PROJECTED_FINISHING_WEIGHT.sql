-- =============================================
-- Author:		Matt Brandt
-- Create date: 10/08/2010
-- Description:	This function projects the expected average pig weight for a pig group at the end of its finishing phase.
-- =============================================
CREATE FUNCTION dbo.cffn_GET_PROJECTED_FINISHING_WEIGHT 
(@PigGroupID char(10))
RETURNS Float
AS
BEGIN
	-- Declare the return variable here
	DECLARE @AvgWeight Float

--Find the earliest closeout date for the group
Declare @KillDate smalldatetime
Select @KillDate = MIN(ps.KillDate)

From [$(SolomonApp)].dbo.cfvPIGSALEREV ps
	Inner Join [$(SolomonApp)].dbo.cftPM pm on pm.PMLoadId = ps.PMLoadID
	Inner Join [$(SolomonApp)].dbo.cftMarketSaleType mst on pm.MarketSaleTypeID = mst.MarketSaleTypeID
	Inner Join [$(SolomonApp)].dbo.cftPigGroup pg on ps.PigGroupID = pg.PigGroupID

Where ps.SaleTypeID='MS'
	And ps.PigGroupID = @PigGroupID
	And RTrim(mst.Description) = 'Closeout'



Declare @PigSale Table  
(PigGroupID char(10)
, EstStartWeight Int
, TattooNbr char(6)
, DaysCounter Int
, HCTot Int
, ProjectedWeight Float)


Insert Into @PigSale

Select pg.PigGroupID, pg.EstStartWeight, ps.TattooNbr, DateDiff(dd,pg.ActStartDate,ps.KillDate) As DaysCounter, ps.HCTot
, Null

From [$(SolomonApp)].dbo.cfvPIGSALEREV ps
	Inner Join [$(SolomonApp)].dbo.cftPM pm on pm.PMLoadId = ps.PMLoadID
	Inner Join [$(SolomonApp)].dbo.cftMarketSaleType mst on pm.MarketSaleTypeID = mst.MarketSaleTypeID
	Inner Join [$(SolomonApp)].dbo.cftPigGroup pg on ps.PigGroupID = pg.PigGroupID

Where ps.SaleTypeID='MS'
	And ps.PigGroupID = @PigGroupID
	And RTrim(mst.Description) = 'Closeout'
	

While Exists (Select * From @PigSale Where DaysCounter > 0)

	Begin
	
	Update p
	Set ProjectedWeight = Case When ProjectedWeight Is Null 
		Then EstStartWeight+
			(Select a.AverageDailyGain
			From  dbo.cft_AVERAGE_DAILY_GAIN a
			Where EstStartWeight Between a.LowWeight And a.HighWeight
				And a.EffectiveStartDate <= @KillDate
				And (a.EffectiveEndDate >= @KillDate Or a.EffectiveEndDate Is Null))*
			Case When DaysCounter >= 7 Then 7 Else DaysCounter End
			
		Else ProjectedWeight+
			(Select a.AverageDailyGain
			From  dbo.cft_AVERAGE_DAILY_GAIN a
			Where ProjectedWeight Between a.LowWeight And a.HighWeight
				And a.EffectiveStartDate <= @KillDate
				And (a.EffectiveEndDate >= @KillDate Or a.EffectiveEndDate Is Null))*
			Case When DaysCounter >= 7 Then 7 Else DaysCounter End
		End
	
	, DaysCounter = Case When DaysCounter < 7 Then 0 Else DaysCounter-7 End
	
	From @PigSale p
	
	End

Select @AvgWeight = Sum(HCTot*ProjectedWeight)/Sum(HCTot)
From @PigSale

	-- Return the result of the function
	RETURN @AvgWeight

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_GET_PROJECTED_FINISHING_WEIGHT] TO [db_sp_exec]
    AS [dbo];


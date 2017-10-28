
-- =============================================
-- Author:		Doran Dahle
-- Create date: 4/11/2012
-- Description:	Used by the Market Optimizer to calculate the Trucking cost
-- =============================================
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2014-09-11  Doran Dahle Changed the BaseRate to use the cftMileageRate table
						

===============================================================================
*/

CREATE Function [dbo].[cff_getBaseRate]
	(@Miles decimal(10,6),@Sundaydate as smalldatetime)
RETURNS Decimal(10,2)

AS
BEGIN
	DECLARE @Rate decimal(10,6),@FuelRate as decimal(10,3),@FuelSurcharge as float, @FuelSurchargeDiff as Decimal(10,3)
	DECLARE @BaseRate as float, @HighMiles smallint

		Set @Miles=Ceiling(@Miles)
		SET @Rate=0
		SET @BaseRate = 0
		
		SET @BaseRate=(Select Rate from cftMileageRate where @Miles between LowMiles and HighMiles)
		SET @FuelRate=(Select FuelRate from cftFuelRate where EffectiveWeek=@SundayDate)
		SET @FuelRate=isnull(@FuelRate,0)
		--SET @HighMiles=(Select HighMiles from cftMileageRate where @Miles between LowMiles and HighMiles)
		SET @FuelSurchargeDiff=(Select Multiplier from cftFuelChargeCat where @FuelRate between MinFuelPrice and MaxFuelPrice)
		SET @FuelSurchargeDiff=isnull(@FuelSurchargeDiff,0)
		--SET @FuelSurcharge=((@FuelSurchargeDiff*2)/5.5)
		SET @FuelSurcharge=(@FuelSurchargeDiff*((@Miles*2)/5.5))
		
		IF @BaseRate>0 BEGIN 
			--SET @Rate=ROUND(((@BaseRate +@FuelSurcharge) * @Miles),2)
			SET @Rate=ROUND(((@BaseRate) * @Miles) +@FuelSurcharge,2)
			SET @Rate=Ceiling(isnull(@Rate,0)) 
		END

RETURN @Rate 
END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[cff_getBaseRate] TO [MSDSL]
    AS [dbo];



/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2015-09-15	Doran Dahle New,  Moved the sql from the getRate Function.
===============================================================================
*/
CREATE Function [dbo].[getRateFuelSurcharge]
	(@PMLoadID as varchar(10),@PMID as varchar(10), @Sundaydate as smalldatetime)
	
RETURNS Decimal(10,2)

AS
BEGIN

IF @PMID=@PMLoadID --this load should display the rate
	BEGIN
		DECLARE	@Miles decimal(10,6)
		,@NewMiles as decimal(10,6)
		,@HighMiles smallint
		,@FuelRate as decimal(10,3)
		,@FuelSurcharge as decimal(10,3)
		,@FuelSurchargeDiff as Decimal(10,3)
				
		set @Miles=dbo.getRateMiles(@PMLoadID,@PMID)
		
		SET @HighMiles=(Select HighMiles from cftMileageRate where @Miles between LowMiles and HighMiles)
		
		SET @FuelRate=(Select FuelRate from cftFuelRate where EffectiveWeek=@SundayDate)
		SET @FuelRate=isnull(@FuelRate,0)
		
		SET @FuelSurchargeDiff=(Select Multiplier from cftFuelChargeCat where @FuelRate between MinFuelPrice and MaxFuelPrice)
		SET @FuelSurchargeDiff=isnull(@FuelSurchargeDiff,0)
		SET @FuelSurcharge=(@FuelSurchargeDiff*((@Miles*2)/5.5))
	END
ELSE
	BEGIN SET @FuelSurcharge=0 END

RETURN @FuelSurcharge  
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[getRateFuelSurcharge] TO [MSDSL]
    AS [dbo];


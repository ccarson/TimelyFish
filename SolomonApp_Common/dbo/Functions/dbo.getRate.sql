



/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2012-04-11  Doran Dahle Changed how the BaseRate is calculated. Added polynomial calculation
2013-12-13  BMD			Changed the "stop" rate from 15 to 50 per Jason Williams						
						Changed the hardcoded value from 15 in the calculation to the new variable called @StopCharge and set that to 50
						Also added in extra payments for multiple destinations as the original code only looked at multiple sources for extra pay
2014-09-20	Doran Dahle Changed how the BaseRate is calculated. Removed polynomial calculation
2015-07-17	Doran Dahle Added the Market exclusion on the Offload check2015-09-15	Doran Dahle Changed to call getRateMiles, getFuelSurcharge, and getStops functions.
===============================================================================
*/

CREATE Function [dbo].[getRate]
	(@PMLoadID as varchar(10),@PMID as varchar(10), @Sundaydate as smalldatetime,
	@PigTypeID as varchar(2),@PigSystemID as varchar(2),@Trailer as varchar(3),@TranTypeID as varchar(2))
RETURNS Decimal(10,2)

AS
BEGIN
DECLARE @Rate decimal(10,6),@PMTypeID as varchar(2), @StopCharge decimal(5,2)
Set @PMTypeID=(Select TOP 1 PMTypeID from cftPM where PMID=@PMID)

IF @PMID=@PMLoadID --this load should display the rate
	BEGIN
		DECLARE @Miles decimal(10,6)
		DECLARE @FuelSurcharge as float 
		DECLARE @BaseRate as float
		
		SET @StopCharge = dbo.getStopsPay(@PMLoadID,@PMID)
		SET @Miles=dbo.getRateMiles(@PMLoadID,@PMID)
		SET @Rate=0
		SET @BaseRate = 0
		IF @PigTypeID ='04' BEGIN
			IF Left(@TranTypeID,1)='O' and right(@TranTypeID,1) not in ('T','M') BEGIN
				SET @Rate=(Select CommRate from cftMileageRate where @Miles between LowMiles and HighMiles)
				END
			ELSE BEGIN
				IF @Miles < 75 BEGIN SET @Miles = 75 END
				SET @BaseRate=(Select Rate from cftMileageRate where @Miles between LowMiles and HighMiles)
				END
			END
		IF @PigSystemID='01' and @PigTypeID<>'04' BEGIN
			SET @Rate=(Select HHRate from cftMileageRate where @Miles between LowMiles and HighMiles)
			END
		IF @PigSystemID='00' and @PigTypeID<>'02' and @PigTypeID<>'04' BEGIN
			SET @Rate=(Select CommRate from cftMileageRate where @Miles between LowMiles and HighMiles)
		END

		SET @FuelSurcharge=dbo.getRateFuelSurcharge(@PMLoadID,@PMID,@SundayDate)
		
		IF @BaseRate>0 BEGIN 
			SET @Rate=ROUND(((@BaseRate) * @Miles)  +@FuelSurcharge +@StopCharge,2)
		END
		IF @PMTypeID='02' BEGIN
			SET @Rate=Ceiling(isnull(@Rate,0)) 
		END
		ELSE BEGIN 
			Set @Rate=0 
		END
	END
ELSE BEGIN 
	SET @Rate=0 
END

RETURN @Rate 
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[getRate] TO PUBLIC
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[getRate] TO [SOLOMON]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[getRate] TO [SE\Earth~WTF~DataReader]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[getRate] TO [MSDSL]
    AS [dbo];


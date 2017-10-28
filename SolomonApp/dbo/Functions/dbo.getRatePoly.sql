


/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2012-04-11  Doran Dahle Changed how the BaseRate is calculated.  Added polynomial calculation
2013-12-13  BMD			Changed the "stop" rate from 15 to 50 per Jason Williams						
						Changed the hardcoded value from 15 in the calculation to the new variable called @StopCharge and set that to 50
						Also added in extra payments for multiple destinations as the original code only looked at multiple sources for extra pay
2014-09-25  Doran Dahle Renamed the old GetRate function so that it could be used to compare polynomial calculation to the bracket calculation.	Hardcoded p1 to .35					
===============================================================================
*/

CREATE Function [dbo].[getRatePoly]
	(@PMLoadID as varchar(10),@PMID as varchar(10), @Sundaydate as smalldatetime,
	@PigTypeID as varchar(2),@PigSystemID as varchar(2),@Trailer as varchar(3),@TranTypeID as varchar(2))
RETURNS Decimal(10,2)

AS
BEGIN
DECLARE @TruckerID as varchar(6),@Rate decimal(10,6),@PMTypeID as varchar(2), @StopCharge decimal(4,2)

Set @TruckerID=(Select TOP 1 TruckerContactID from cftPM where PMID=@PMID)
Set @PMTypeID=(Select TOP 1 PMTypeID from cftPM where PMID=@PMID)

Set @StopCharge=50

IF @PMID=@PMLoadID --this load should display the rate
	BEGIN
		DECLARE @StartSite varchar(6), @EndSite varchar(6), 
			@Miles decimal(10,6),@NewMiles as decimal(10,6)
			
		--DECLARE @Wash smallint, @Disinfect smallint, 
		DECLARE @Stops smallint, @PayWash as smallint
		DECLARE @FuelRate as decimal(10,3),@FuelSurcharge as float, @FuelSurchargeDiff as Decimal(10,3)
		DECLARE @SourceContactID varchar(6),  @LoadTime smalldatetime, @TrailerWashFlg smallint, @DisinfectFlg smallint
		DECLARE @P1 as float, @BaseRate as float
		
		DECLARE MilesCursor CURSOR LOCAL FORWARD_ONLY READ_ONLY FOR
		Select DestContactID,max(arrivaldate+CONVERT(CHAR(8),arrivaltime,24)),TrailerWashFlag,DisinfectFlg
		from cftPm where PMLoadID=@PMLoadID
		group by DestContactID,TrailerWashFlag,DisinfectFlg
		union
		Select sourceContactID, min(movementdate+CONVERT(CHAR(8),loadingtime,24)),TrailerWashFlag,DisinfectFlg
		from cftPm where PMLoadID=@PMLoadID
		group by sourceContactID,TrailerWashFlag,DisinfectFlg
		order by 2

		OPEN MilesCursor
		
		FETCH NEXT FROM MilesCursor INTO @SourceContactID ,@LoadTime, @TrailerWashFlg, @DisinfectFlg
		
		SET @EndSite  = ''
		SET @Miles = 0
		SET @Stops=0
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
		    SET @StartSite = @SourceContactID
		    IF @EndSite<>''
		       SET @NewMiles=(Select isnull(OneWayMiles,0) from vcfContactMilesMatrix 
						where SourceSite=@StartSite and DestSite=@EndSite)
			IF @NewMiles>0 BEGIN Set @Miles=@Miles+@NewMiles END
			--IF @TrailerWashFlg<>0 BEGIN SET @Wash=1 END
			--IF @DisinfectFlg<>0 BEGIN SET @Disinfect=1 END
		    SET @EndSite = @SourceContactID
		
		    FETCH NEXT FROM MilesCursor INTO @SourceContactID,@LoadTime, @TrailerWashFlg, @DisinfectFlg
		END
		
		-- Get the number of Source stops
		SET @Stops=(Select Count(t.SourceContactID) from (Select Distinct SourceContactID from cftPM where PMLoadID=@PMLoadID) as t)
		-- Add in the number of Destination Stops
		SET @Stops=@Stops+(Select Count(t.DestContactID) from (Select Distinct DestContactID from cftPM where PMLoadID=@PMLoadID) as t)
		-- Now subtract one source and destination stop as we don't pay extra for one source and one destination
		SET @Stops=@Stops-2
		
		Set @Miles=Ceiling(@Miles)
		SET @Rate=0
		SET @BaseRate = 0
		IF @PigTypeID ='04' BEGIN
			IF Left(@TranTypeID,1)='O' BEGIN
				SET @Rate=(Select CommRate from cftMileageRate where @Miles between LowMiles and HighMiles)
				END
			ELSE BEGIN
				IF @Miles < 75 BEGIN SET @Miles = 75 END
				SET @P1 = .35 --(Select Rate from cftMileageRate where @Miles between LowMiles and HighMiles)
				IF @Miles <= 250 BEGIN 
					SET @BaseRate = (0.000000003292102 * POWER(@Miles, 4)) + (- 0.000002806753371 * POWER(@Miles, 3)) +(0.000897363038467 * POWER(@Miles, 2)) + (- 0.12881303481807 * @Miles) + 9.41015721505232 + @P1
					END
				ELSE BEGIN
					SET @BaseRate = (0.000000167420088 * POWER(@Miles, 2)) + (- 0.000299969340313 * @Miles) + 2.3552845006343 + @P1
				END	
			END
		END
		IF @PigSystemID='01' and @PigTypeID<>'04' BEGIN
			SET @Rate=(Select HHRate from cftMileageRate where @Miles between LowMiles and HighMiles)
			END
		IF @PigSystemID='00' and @PigTypeID<>'02' and @PigTypeID<>'04' BEGIN
			SET @Rate=(Select CommRate from cftMileageRate where @Miles between LowMiles and HighMiles)
			END
				
		SET @FuelRate=(Select FuelRate from cftFuelRate where EffectiveWeek=@SundayDate)
		SET @FuelRate=isnull(@FuelRate,0)
		
		SET @FuelSurchargeDiff=(Select Multiplier from cftFuelChargeCat where @FuelRate between MinFuelPrice and MaxFuelPrice)
		SET @FuelSurchargeDiff=isnull(@FuelSurchargeDiff,0)
		SET @FuelSurcharge=((@FuelSurchargeDiff*2)/5.5)
		
		IF @BaseRate>0 BEGIN 
			SET @Rate=ROUND(((@BaseRate +@FuelSurcharge) * @Miles),2)
			IF @Stops>0 BEGIN SET @Rate=@Rate + (@Stops*@StopCharge)  END
			--SET @PayWash=(Select TruckWashFlag from cftPigTrailer where PigTrailerID=@Trailer)
			--IF @PayWash=0 or @Trailer=''
			--	BEGIN
			--		IF @Wash=1 BEGIN SET @Rate=@Rate+100 END
			--	END
		END
		IF @PMTypeID='02'
			BEGIN
				SET @Rate=Ceiling(isnull(@Rate,0)) 
			END
		ELSE
			BEGIN Set @Rate=0 END

		CLOSE MilesCursor
		DEALLOCATE MilesCursor
				
	END
ELSE
	BEGIN SET @Rate=0 END

RETURN @Rate 
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[getRatePoly] TO [MSDSL]
    AS [dbo];



Create Function [dbo].[getPackerRate]
	(@MovementDate as smalldatetime,
	@PackerID as int,
	@ArriveTime as datetime,
	@ThisTruckerTrailerID as int,
	@ThisSiteID as int,
	@ThisLoadTime as datetime)
RETURNS DECIMAL(10,2)
--RETURNS smalldatetime
AS
BEGIN

	DECLARE @StartSite as int
	DECLARE @EndSite as int
	
	DECLARE Movement_Cursor CURSOR 
	FOR SELECT c.ContactID, SourceSiteID,LoadingTime,DestinationSiteID, TrailerWashFlag, tt.ContactID as TruckerID
		FROM dbo.MarketMovement mm
		JOIN CentralData.dbo.vSitewithContactName c on mm.SourceSiteID=c.ContactID
		JOIN CentralData.dbo.MarketTrucker tt on mm.TruckerTrailerID=tt.MarketTruckerID
		WHERE MovementDate=@MovementDate and mm.TruckerTrailerID=@ThisTruckerTrailerID and ArrivalTime=@ArriveTime and DestinationSiteID=@PackerID
		ORDER by LoadingTime
	OPEN Movement_Cursor
	DECLARE @SourceSiteID as int
	DECLARE @SiteID as int
	DECLARE @DestinationSiteID as int
	DECLARE @TrailerWashFlag as int
	DECLARE @TruckerID as int
	DECLARE @LoadingTime as datetime
	DECLARE @Rate as Decimal(10,2)
	DECLARE @Miles as Decimal(10,2)
	DECLARE @Wash as smallint
	DECLARE @HighMiles as smallint
	DECLARE @FuelSurchargeDiff as decimal(10,2)
	DECLARE @FuelSurcharge as decimal(10,2)
	DECLARE @FuelRate      as Decimal(10,2)
	DECLARE @Stops		as integer
	Set @Wash=0
	Set @Rate=0
	Set @StartSite=0
	Set @Miles=0
	Set @Stops=(SELECT Count(SourceSiteID)
		FROM dbo.MarketMovement mm
		JOIN CentralData.dbo.MarketTrucker tt on mm.TruckerTrailerID=tt.MarketTruckerID
		WHERE MovementDate=@MovementDate and mm.TruckerTrailerID=@ThisTruckerTrailerID and ArrivalTime=@ArriveTime and DestinationSiteID=@PackerID
			and SourceSiteID<>@ThisSiteID)
	FETCH NEXT FROM Movement_Cursor INTO @SourceSiteID, @SiteID, @LoadingTime, @DestinationSiteID, @TrailerWashFlag, @TruckerID
	IF @TrailerWashFlag=-1
		BEGIN
		SET @Wash=1
		END
	IF @ThisSiteID=@SiteID and @ThisLoadTime=@LoadingTime
	BEGIN
		IF @@FETCH_STATUS=0
		BEGIN
		SET @Miles=dbo.CalcDistance(@SourceSiteID, @DestinationSiteID)
		END
		ELSE
		BEGIN
		WHILE @@FETCH_STATUS=0
		BEGIN
		Set @StartSite=@SourceSiteID
		
		FETCH NEXT FROM Movement_Cursor INTO @SourceSiteID, @SiteID, @LoadingTime, @DestinationSiteID, @TrailerWashFlag, @TruckerID
		
		IF @TrailerWashFlag=-1 and @TruckerID<>945
			BEGIN
			SET @Wash=1
			END
		Set @EndSite=@SourceSiteID
		Set @Miles=@Miles + dbo.CalcDistance(@StartSite, @EndSite)
		END
		Set @Miles=@Miles + dbo.CalcDistance(@SourceSiteID,@DestinationSiteID)
		END
		Set @Miles=Ceiling(@Miles)
		SET @Rate=(Select Rate from CentralData.dbo.MileageRate where @Miles between LowMiles and HighMiles)
		SET @Rate=@Rate+(@Stops*15)

			Set @HighMiles=(Select HighMiles from CentralData.dbo.MileageRate where @Miles between LowMiles and HighMiles)
			IF @MovementDate>=cast('10/10/2004' as smalldatetime)
			BEGIN
			SET @FuelRate=(Select FuelRate from FuelRates where @MovementDate between EffectiveWeek and DateAdd(d,6,EffectiveWeek))
			SET @FuelRate=isnull(@FuelRate,0)
			SET @FuelSurchargeDiff=@FuelRate-(Select isnull(BaseSurcharge,0) from FuelSurchargeSetup)
			SET @FuelSurchargeDiff=(Select isnull(Multiplier,0) from FuelChargeCategory where @FuelRate between MinFuelPrice and MaxFuelPrice)
			SET @FuelSurcharge=(@FuelSurchargeDiff*((@HighMiles*2)/5))
			Set @Rate=@Rate+@FuelSurcharge
			END 
		IF @Wash=1 and @TruckerID<>945  
			BEGIN
			Set @Rate=@Rate+75
			END

		END
	--ELSE
		--BEGIN
		--SET @Rate=0
		--END
	
	CLOSE Movement_Cursor
	DEALLOCATE Movement_Cursor
	
	RETURN @Rate
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[getPackerRate] TO [MSDSL]
    AS [dbo];


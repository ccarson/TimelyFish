CREATE Function [dbo].[getPackerRate]
	(@MovementDate as smalldatetime,
	@PackerID as int,
	@ArriveTime as datetime,
	@ThisTruckerTrailerID as int,
	@ThisSiteID as int,
	@ThisLoadTime as datetime)
RETURNS DECIMAL(10,2)
AS
BEGIN

	DECLARE @StartSite as int
	DECLARE @EndSite as int
	
	DECLARE Movement_Cursor CURSOR 
	FOR SELECT c.ContactID, SourceSiteID,LoadingTime,DestinationSiteID, TrailerWashFlag, tt.ContactID as TruckerID
		FROM dbo.MarketMovement mm
		JOIN dbo.vSitewithContactName c on mm.SourceSiteID=c.ContactID
		JOIN dbo.MarketTrucker tt on mm.TruckerTrailerID=tt.MarketTruckerID
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
	Set @Wash=0
	Set @Rate=0
	Set @StartSite=0
	Set @Miles=0
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
		SET @Rate=(Select Rate from dbo.MileageRate where @Miles between LowMiles and HighMiles)
		IF @Wash=1 and @TruckerID<>620 and @TruckerID<>945  
			BEGIN
			Set @Rate=@Rate+75
			END
		ELSE IF @Wash=1 and @TruckerID=620
			BEGIN 
			SET @Rate=@Rate+85
			END
		END
	ELSE
		BEGIN
		SET @Rate=0
		END
	
	CLOSE Movement_Cursor
	DEALLOCATE Movement_Cursor
	
	RETURN @Rate
END



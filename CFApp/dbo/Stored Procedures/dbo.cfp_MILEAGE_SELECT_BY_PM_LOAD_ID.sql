-- ====================================================================================
-- Author:		Brian Cesafsky
-- Create date: 05/12/2010
-- Description:	Returns total mileage for a transportation load based on the PMLoadID
-- ====================================================================================
CREATE PROCEDURE [dbo].[cfp_MILEAGE_SELECT_BY_PM_LOAD_ID]
(
	@PMLoadID		int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		 PMLoadID
		,PMID
		,SourceContact.ContactName as Source
		,SourceContact.ContactID as SourceContactID
		,LoadingTime
		,ArrivalDate
		,ArrivalTime
		,MovementDate
		,DestContact.ContactName as Dest
		,DestContact.ContactID as DestContactID
		,TrailerSourceContactID
		,TrailerDestinationContactID
		,TruckerContactID
	into #BaseData
	from [$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
		left join [$(SolomonApp)].dbo.cftContact SourceContact (NOLOCK)
		on cftPM.SourceContactID=SourceContact.ContactID
	left join [$(SolomonApp)].dbo.cftContact DestContact (NOLOCK)
		on cftPM.DestContactID=DestContact.ContactID
	where pmloadid = @PMLoadID
	order by LoadingTime
		  ,ArrivalTime

	DECLARE @TrailerSourceContactID INT
	DECLARE @TrailerDestinationContactID INT

	-- find @TrailerSourceContactID
	IF (SELECT COUNT(*) FROM #BaseData WHERE RTRIM(TrailerSourceContactID) <> '') > 0
		  SELECT @TrailerSourceContactID = CAST(TrailerSourceContactID AS INT) FROM #BaseData WHERE RTRIM(TrailerSourceContactID) <> ''
	ELSE
		  SELECT @TrailerSourceContactID = NULL

	-- find @TrailerDestinationContactID
	IF (SELECT COUNT(*) FROM #BaseData WHERE RTRIM(TrailerDestinationContactID) <> '') > 0
		  SELECT @TrailerDestinationContactID = CAST(TrailerDestinationContactID AS INT) FROM #BaseData WHERE RTRIM(TrailerDestinationContactID) <> ''
	ELSE
		  SELECT @TrailerDestinationContactID = NULL


	--create mileage table to step thru
	CREATE TABLE #StepMileage (ContactID INT)

	----------------------------------------------------------------
	--if source trailer, this is our starting point
	----------------------------------------------------------------
	IF @TrailerSourceContactID IS NOT NULL
	BEGIN
		  INSERT INTO #StepMileage
		  SELECT @TrailerSourceContactID
	END   

	------------------------------------------------------------------
	----source pickups
	------------------------------------------------------------------
	--SELECT CAST(SourceContactID AS INT) SourceContactID, LoadingTime INTO #SourceList FROM #BaseData GROUP BY SourceContactID, LoadingTime ORDER BY LoadingTime

	--INSERT INTO #StepMileage
	--select SourceContactID from #SourceList

	------------------------------------------------------------------
	----destination pickups
	------------------------------------------------------------------
	--SELECT CAST(DestContactID AS INT) DestContactID, ArrivalTime INTO #DestinationList FROM #BaseData GROUP BY DestContactID, ArrivalTime ORDER BY ArrivalTime

	--INSERT INTO #StepMileage
	--select DestContactID from #DestinationList
	
	----------------------------------------------------------------
	--source pickups
	----------------------------------------------------------------
	SELECT CAST(SourceContactID AS INT) SourceContactID, MovementDate, LoadingTime INTO #SourceList FROM #BaseData GROUP BY SourceContactID, MovementDate, LoadingTime ORDER BY MovementDate, LoadingTime

	INSERT INTO #StepMileage
	select SourceContactID from #SourceList

	----------------------------------------------------------------
	--destination pickups
	----------------------------------------------------------------
	SELECT CAST(DestContactID AS INT) DestContactID, ArrivalDate, ArrivalTime INTO #DestinationList FROM #BaseData GROUP BY DestContactID, ArrivalDate, ArrivalTime ORDER BY ArrivalDate, ArrivalTime

	INSERT INTO #StepMileage
	select DestContactID from #DestinationList



	----------------------------------------------------------------
	--if destination trailer, this is our ending point
	----------------------------------------------------------------
	IF @TrailerDestinationContactID IS NOT NULL
	BEGIN
		  INSERT INTO #StepMileage
		  SELECT @TrailerDestinationContactID
	END   


	----------------------------------------------------------------
	--cursor through #StepMileage table asynchronously, calc mileage
	----------------------------------------------------------------
	DECLARE @S_ContactID INT
	DECLARE @D_ContactID INT
	DECLARE @OneWayMiles FLOAT
	DECLARE @RestrictOneWayMiles FLOAT
	DECLARE @OneWayHours FLOAT
	DECLARE @RestrictOneWayHours FLOAT
	SET @S_ContactID = NULL
	SET @D_ContactID = NULL
	SET @OneWayMiles = 0.0
	SET @RestrictOneWayMiles = 0.0
	SET @OneWayHours = 0.0
	SET @RestrictOneWayHours = 0.0

	DECLARE miles_cursor CURSOR FOR 
	SELECT ContactID
	FROM #StepMileage

	OPEN miles_cursor

	FETCH NEXT FROM miles_cursor 
	INTO @D_ContactID

	WHILE @@FETCH_STATUS = 0
	BEGIN

	IF @S_ContactID IS NOT NULL
	--PRINT '>> ' + cast(@S_ContactID as varchar) + ' - ' + cast(@D_ContactID as varchar)
	BEGIN
		  SELECT
				@OneWayMiles = @OneWayMiles + mm.OneWayMiles
		  ,     @RestrictOneWayMiles = @RestrictOneWayMiles + mm.RestrictOneWayMiles
		  ,     @OneWayHours = @OneWayHours + mm.OneWayHours
		  ,     @RestrictOneWayHours = @RestrictOneWayHours + mm.RestrictOneWayHours
		  FROM [$(CentralData)].dbo.MilesMatrix mm (NOLOCK)
		  INNER JOIN [$(CentralData)].dbo.ContactAddress fc (NOLOCK)
				ON fc.AddressID = mm.AddressIdFrom
		  INNER JOIN [$(CentralData)].dbo.ContactAddress tc (NOLOCK)
				ON tc.AddressID = mm.AddressIDTo
		  WHERE fc.ContactID = @S_ContactID
		  AND tc.ContactID = @D_ContactID
	END

		  SET @S_ContactID = @D_ContactID

		  FETCH NEXT FROM miles_cursor 
		  INTO @D_ContactID
	END

	CLOSE miles_cursor
	DEALLOCATE miles_cursor

--select * from #BaseData
--select * from #StepMileage

	SELECT 
		  @PMLoadID PMLoadID
		, @OneWayMiles OneWayMiles
		, @RestrictOneWayMiles RestrictOneWayMiles
		, @OneWayHours OneWayHours
		, @RestrictOneWayHours RestrictOneWayHours
		, cast(FLOOR(cast(@OneWayHours as numeric(10,2))) as varchar)+ ':' 
			+ cast(cast(60 * (cast(@OneWayHours as numeric(10,2)) - cast(FLOOR(@OneWayHours) as int)) as int) as varchar) OneWayHoursMins
		, cast(FLOOR(cast(@RestrictOneWayHours as numeric(10,2))) as varchar)+ ':' 
			+ cast(cast(60 * (cast(@RestrictOneWayHours as numeric(10,2)) - cast(FLOOR(@RestrictOneWayHours) as int)) as int) as varchar) RestrictOneWayHoursMins

	drop table #BaseData
	drop table #SourceList
	drop table #DestinationList
	drop table #StepMileage

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MILEAGE_SELECT_BY_PM_LOAD_ID] TO [db_sp_exec]
    AS [dbo];


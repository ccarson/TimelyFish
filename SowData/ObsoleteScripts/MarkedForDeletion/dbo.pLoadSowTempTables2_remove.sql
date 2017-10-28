
CREATE PROCEDURE [pLoadSowTempTables2_remove]
	@FarmID varchar(8), @BegDate smalldatetime
	AS
	DECLARE @FirstDate smalldatetime
	SELECT @FirstDate = @BegDate - 365

	-- CLEAR OUT THE TEMPORARY TABLES
	TRUNCATE TABLE SowFalloutEventTemp
	TRUNCATE TABLE SowFarrowEventTemp
	TRUNCATE TABLE SowFosterEventTemp
	TRUNCATE TABLE SowGroupEventTemp
	TRUNCATE TABLE SowLocationEventTemp
	TRUNCATE TABLE SowMatingEventTemp
	TRUNCATE TABLE SowNonServiceEventTemp
	TRUNCATE TABLE SowNurseEventTemp
	TRUNCATE TABLE SowPigletDeathEventTemp
	TRUNCATE TABLE SowPregExamEventTemp
	TRUNCATE TABLE SowRemoveEventTemp
	TRUNCATE TABLE SowTemp
	TRUNCATE TABLE SowWeanEventTemp
	TRUNCATE TABLE SowParityTemp

	-- TO SAVE RESOURCES TURN OFF SQL's RETURNING ITEM COUNTS
	SET NOCOUNT ON
	
	--RELOAD THE TEMPORARY TABLES
	INSERT INTO SowFalloutEventTemp
		SELECT * FROM SowFalloutEvent WHERE FarmID = @FarmID AND EventDate >= @FirstDate
	INSERT INTO SowFarrowEventTemp
		SELECT * FROM SowFarrowEvent WHERE FarmID = @FarmID AND EventDate >= @FirstDate
	INSERT INTO SowFosterEventTemp
		SELECT * FROM SowFosterEvent WHERE FarmID = @FarmID AND EventDate >= @FirstDate
	INSERT INTO SowGroupEventTemp
		SELECT * FROM SowGroupEvent WHERE FarmID = @FarmID AND EventDate >= @FirstDate
	INSERT INTO SowLocationEventTemp
		SELECT * FROM SowLocationEvent WHERE FarmID = @FarmID AND EventDate >= @FirstDate
	INSERT INTO SowMatingEventTemp
		SELECT * FROM SowMatingEvent WHERE FarmID = @FarmID AND EventDate >= @FirstDate
	INSERT INTO SowNonServiceEventTemp
		SELECT * FROM SowNonServiceEvent WHERE FarmID = @FarmID AND EventDate >= @FirstDate
	INSERT INTO SowNurseEventTemp
		SELECT * FROM SowNurseEvent WHERE FarmID = @FarmID AND EventDate >= @FirstDate
	INSERT INTO SowPigletDeathEventTemp
		SELECT * FROM SowPigletDeathEvent WHERE FarmID = @FarmID AND EventDate >= @FirstDate
	INSERT INTO SowPregExamEventTemp
		SELECT * FROM SowPregExamEvent WHERE FarmID = @FarmID AND EventDate >= @FirstDate
	INSERT INTO SowRemoveEventTemp
		SELECT * FROM SowRemoveEvent WHERE FarmID = @FarmID AND EventDate >= @FirstDate
	INSERT INTO SowTemp
		SELECT * FROM Sow WHERE FarmID = @FarmID 
	INSERT INTO SowWeanEventTemp
		SELECT * FROM SowWeanEvent WHERE FarmID = @FarmID AND EventDate >= @FirstDate
	INSERT INTO SowParityTemp
		SELECT * FROM SowParity WHERE FarmID = @FarmID AND EffectiveDate >= @FirstDate
	SET NOCOUNT OFF


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pLoadSowTempTables2_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pLoadSowTempTables2_remove] TO [se\analysts]
    AS [dbo];


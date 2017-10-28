CREATE PROCEDURE [dbo].[pSowEventHistory_remove] @FarmID varchar(8), @SowID varchar(12)
	AS
	SET NOCOUNT ON
	CREATE TABLE #SowEventHistory (FarmID varchar(8), SowID varchar(12), SowParity varchar(3),
		EventDate smalldatetime, Event1KDate varchar(6), EventType varchar(20), EventData varchar(100), SortCode int)	

	INSERT INTO #SowEventHistory
	SELECT FarmID, SowID, SowParity = LTrim(RTrim(convert(varchar(3),InitialParity))), EventDate = EntryDate, 
	Event1KDate = dbo.ConvertDateTo1000Day(EntryDate), EventType = 'ENTER',EventData = ' ',SortCode = 1  
	FROM sow 
	WHERE FarmID = @FarmID and SowID = @SowID

	INSERT INTO #SowEventHistory
	SELECT FarmID, SowID, SowParity = LTrim(RTrim(convert(varchar(3),SowParity))), EventDate, 
	Event1KDate = dbo.ConvertDateTo1000Day(EventDate), EventType = 'FARROW', 
	EventData = 'BA: ' + LTrim(RTrim(convert(varchar(3),IsNull(QtyBornAlive,0)))) + 
		'  SB: ' + LTrim(RTrim(convert(varchar(3),IsNull(QtyStillBorn,0)))) + 
		'  Mum: ' + LTrim(RTrim(convert(varchar(3),IsNull(QtyMummy,0)))) + '  Induce: ' + IsNull(Induced,'') + '  Assist: ' + IsNull(Assisted,''),
	SortCode 
	FROM SowFarrowEvent
	WHERE FarmID = @FarmID and SowID = @SowID

	INSERT INTO #SowEventHistory
	SELECT FarmID, SowID, SowParity = '', EventDate, 
	Event1KDate = dbo.ConvertDateTo1000Day(EventDate),EventType, 
	EventData = '', SortCode 
	FROM SowFalloutEvent
	WHERE FarmID = @FarmID and SowID = @SowID

	INSERT INTO #SowEventHistory
	SELECT FarmID, SowID, SowParity = '', EventDate, 
	Event1KDate = dbo.ConvertDateTo1000Day(EventDate), EventType = 'FOSTER', 
	EventData = 'Qty: ' + LTrim(RTrim(convert(varchar(4),Qty))) , SortCode 
	FROM SowFosterEvent
	WHERE FarmID = @FarmID and SowID = @SowID

	INSERT INTO #SowEventHistory
	SELECT FarmID, SowID, SowParity = '', EventDate, 
	Event1KDate = dbo.ConvertDateTo1000Day(EventDate), EventType = 'GROUP', 
	EventData = 'Group ID: ' + GroupID, SortCode 
	FROM SowGroupEvent
	WHERE FarmID = @FarmID and SowID = @SowID

	INSERT INTO #SowEventHistory
	SELECT FarmID, SowID, SowParity = '', EventDate, 
	Event1KDate = dbo.ConvertDateTo1000Day(EventDate), EventType = 'LOCATION', 
	EventData = 'Barn: ' + IsNull(Barn,'') + '  Room: ' + IsNull(Room,'') + '  Crate: ' + IsNull(Crate,''), SortCode 
	FROM SowLocationEvent
	WHERE FarmID = @FarmID and SowID = @SowID

	INSERT INTO #SowEventHistory
	SELECT FarmID, SowID, SowParity = '', EventDate, 
	Event1KDate = dbo.ConvertDateTo1000Day(EventDate), EventType = MatingType, 
	EventData = 'SemenID: ' + IsNull(SemenID,'') + '  Obsv: ' + IsNull(Observer,'') + '  Mating: ' + LTrim(RTrim(convert(varchar(3),MatingNbr))) + '  AMPM: ' + LTrim(RTrim(convert(varchar(3),HourFlag))), SortCode 
	FROM SowMatingEvent
	WHERE FarmID = @FarmID and SowID = @SowID

	INSERT INTO #SowEventHistory
	SELECT FarmID, SowID, SowParity = '', EventDate, 
	Event1KDate = dbo.ConvertDateTo1000Day(EventDate), EventType, 
	EventData = '', SortCode 
	FROM SowNonServiceEvent
	WHERE FarmID = @FarmID and SowID = @SowID

	INSERT INTO #SowEventHistory
	SELECT FarmID, SowID, SowParity = '', EventDate, 
	Event1KDate = dbo.ConvertDateTo1000Day(EventDate), EventType, 
	EventData = 'Qty: ' + LTrim(RTrim(convert(varchar(3),Qty))), SortCode 
	FROM SowNurseEvent
	WHERE FarmID = @FarmID and SowID = @SowID

	INSERT INTO #SowEventHistory
	SELECT FarmID, SowID, SowParity = '', EventDate, 
	Event1KDate = dbo.ConvertDateTo1000Day(EventDate), EventType = 'PIG DEATH', 
	EventData = 'Qty: ' + LTrim(RTrim(convert(varchar(3),Qty))) + '  Reason: ' + IsNull(Reason,'') , SortCode 
	FROM SowPigletDeathEvent
	WHERE FarmID = @FarmID and SowID = @SowID

	INSERT INTO #SowEventHistory
	SELECT FarmID, SowID, SowParity = '', EventDate, 
	Event1KDate = dbo.ConvertDateTo1000Day(EventDate), EventType = 'PREG EXAM', 
	EventData = 'Result: ' + IsNull(ExamResult,'') , SortCode 
	FROM SowPregExamEvent
	WHERE FarmID = @FarmID and SowID = @SowID

	INSERT INTO #SowEventHistory
	SELECT FarmID, SowID, SowParity = '', EventDate, 
	Event1KDate = dbo.ConvertDateTo1000Day(EventDate), EventType = RemovalType, 
	EventData = 'Reason1: ' + IsNull(PrimaryReason,'') + '  Reason2: ' + IsNull(SecondaryReason,'') , SortCode 
	FROM SowRemoveEvent
	WHERE FarmID = @FarmID and SowID = @SowID

	INSERT INTO #SowEventHistory
	SELECT FarmID, SowID, SowParity = '', EventDate, 
	Event1KDate = dbo.ConvertDateTo1000Day(EventDate), EventType, 
	EventData = 'Qty: ' + LTrim(RTrim(convert(varchar(3),Qty))), SortCode 	
	FROM SowWeanEvent
	WHERE FarmID = @FarmID and SowID = @SowID

	SET NOCOUNT OFF
	SELECT * FROM #SowEventHistory ORDER BY SortCode

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pSowEventHistory_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pSowEventHistory_remove] TO [se\analysts]
    AS [dbo];


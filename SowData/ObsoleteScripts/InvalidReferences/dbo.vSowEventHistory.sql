CREATE VIEW [dbo].[vSowEventHistory] (FarmID, SowID, SowParity, EventDate, EventType, EventData, SortCode)
	AS 

	SELECT FarmID, SowID, SowParity = LTrim(RTrim(convert(varchar(3),InitialParity))), EntryDate, 'ENTER','',1  
	FROM sow 

	UNION
	SELECT FarmID, SowID, SowParity = LTrim(RTrim(convert(varchar(3),SowParity))), EventDate, EventType = 'FARROW', 
	EventData = 'BA: ' + LTrim(RTrim(convert(varchar(3),IsNull(QtyBornAlive,0)))) + 
		'  SB: ' + LTrim(RTrim(convert(varchar(3),IsNull(QtyStillBorn,0)))) + 
		'  Mum: ' + LTrim(RTrim(convert(varchar(3),IsNull(QtyMummy,0)))) + '  Induce: ' + IsNull(Induced,'') + '  Assist: ' + IsNull(Assisted,''),
	SortCode 
	FROM SowFarrowEvent

	UNION
	SELECT FarmID, SowID, SowParity = '', EventDate, EventType, 
	EventData = '', SortCode 
	FROM SowFalloutEvent

	UNION
	SELECT FarmID, SowID, SowParity = '', EventDate, EventType = 'FOSTER', 
	EventData = 'Qty: ' + LTrim(RTrim(convert(varchar(4),Qty))) , SortCode 
	FROM SowFosterEvent

	UNION
	SELECT FarmID, SowID, SowParity = '', EventDate, EventType = 'GROUP', 
	EventData = 'Group ID: ' + GroupID, SortCode 
	FROM SowGroupEvent

	UNION
	SELECT FarmID, SowID, SowParity = '', EventDate, EventType = 'LOCATION', 
	EventData = 'Barn: ' + IsNull(Barn,'') + '  Room: ' + IsNull(Room,'') + '  Crate: ' + IsNull(Crate,''), SortCode 
	FROM SowLocationEvent

	UNION
	SELECT FarmID, SowID, SowParity = '', EventDate, EventType = MatingType, 
	EventData = 'SemenID: ' + IsNull(SemenID,'') + '  Obsv: ' + IsNull(Observer,'') + '  Mating: ' + LTrim(RTrim(convert(varchar(3),MatingNbr))) + '  AMPM: ' + LTrim(RTrim(convert(varchar(3),HourFlag))), SortCode 
	FROM SowMatingEvent

	UNION
	SELECT FarmID, SowID, SowParity = '', EventDate, EventType, 
	EventData = '', SortCode 
	FROM SowNonServiceEvent

	UNION
	SELECT FarmID, SowID, SowParity = '', EventDate, EventType, 
	EventData = 'Qty: ' + LTrim(RTrim(convert(varchar(3),Qty))) , SortCode 
	FROM SowNurseEvent

	UNION
	SELECT FarmID, SowID, SowParity = '', EventDate, EventType = 'PIG DEATH', 
	EventData = 'Qty: ' + LTrim(RTrim(convert(varchar(3),Qty))) + '  Reason: ' + IsNull(Reason,'') , SortCode 
	FROM SowPigletDeathEvent

	UNION
	SELECT FarmID, SowID, SowParity = '', EventDate, EventType = 'PREG EXAM', 
	EventData = 'Result: ' + IsNull(ExamResult,'') , SortCode 
	FROM SowPregExamEvent

	UNION
	SELECT FarmID, SowID, SowParity = '', EventDate, EventType = RemovalType, 
	EventData = 'Reason1: ' + IsNull(PrimaryReason,'') + '  Reason2: ' + IsNull(SecondaryReason,'') , SortCode 
	FROM SowRemoveEvent

	UNION
	SELECT FarmID, SowID, SowParity = '', EventDate, EventType, 
	EventData = 'Qty: ' + LTrim(RTrim(convert(varchar(3),Qty))), SortCode 	
	FROM SowWeanEvent

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowEventHistory] TO [se\analysts]
    AS [dbo];


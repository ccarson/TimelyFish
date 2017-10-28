CREATE PROCEDURE [dbo].[pUpdateSowEntryDate_remove]
	@EventDate smalldatetime,
	@InitialParity int,
	@TrueEntryDate varchar(3),
	@FarmID varchar(8),
	@SowID varchar(12)
	As
	UPDATE dbo.Sow 
	SET EntryDate = @EventDate, 
		EntryWeekOfDate = Case DatePart(weekday, @EventDate) 
		WHEN 1 THEN @EventDate
		WHEN 2 THEN DateAdd(day, -1, @EventDate)
		WHEN 3 THEN DateAdd(day, -2, @EventDate)
		WHEN 4 THEN DateAdd(day, -3, @EventDate)
		WHEN 5 THEN DateAdd(day, -4, @EventDate)
		WHEN 6 THEN DateAdd(day, -5, @EventDate)
		WHEN 7 THEN DateAdd(day, -6, @EventDate)
		END,
	InitialParity = @InitialParity, TrueEntryDate = @TrueEntryDate
	WHERE FarmID = @FarmID AND SowID = @SowID

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pUpdateSowEntryDate_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pUpdateSowEntryDate_remove] TO [se\analysts]
    AS [dbo];


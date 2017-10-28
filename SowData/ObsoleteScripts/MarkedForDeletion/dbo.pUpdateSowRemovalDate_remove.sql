CREATE PROCEDURE [dbo].[pUpdateSowRemovalDate_remove]
	@RemovalDate smalldatetime,
	@RemovalType varchar(20),
	@RemovalReason varchar(30),
	@FarmID varchar(8),
	@SowID varchar(12)
	As
	UPDATE dbo.Sow 
	SET RemovalDate = @RemovalDate, 
		RemovalWeekOfDate = Case DatePart(weekday, @RemovalDate) 
		WHEN 1 THEN @RemovalDate
		WHEN 2 THEN DateAdd(day, -1, @RemovalDate)
		WHEN 3 THEN DateAdd(day, -2, @RemovalDate)
		WHEN 4 THEN DateAdd(day, -3, @RemovalDate)
		WHEN 5 THEN DateAdd(day, -4, @RemovalDate)
		WHEN 6 THEN DateAdd(day, -5, @RemovalDate)
		WHEN 7 THEN DateAdd(day, -6, @RemovalDate)
		END,
	RemovalType = @RemovalType, PrimaryReason = @RemovalReason
	WHERE FarmID = @FarmID AND SowID = @SowID

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pUpdateSowRemovalDate_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pUpdateSowRemovalDate_remove] TO [se\analysts]
    AS [dbo];


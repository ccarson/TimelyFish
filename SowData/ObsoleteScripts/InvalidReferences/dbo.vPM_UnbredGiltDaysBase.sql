CREATE VIEW [dbo].[vPM_UnbredGiltDaysBase]
	As
	SELECT v.FarmID, v.SowID, v.WeekOfDate, v.SowGenetics, v.SowParity, v.SowDays, 
		AdjDaysMating = IsNull(datediff(day, v.WeekOfDate-1, (SELECT Min(EventDate) FROM dbo.SowMatingEvent Where FarmID = v.FarmID and SowID = v.SowID and WeekOfDate = v.WeekOfDate)),0),
		FirstMatingDate = (SELECT Min(EventDate) FROM dbo.SowMatingEvent Where FarmID = v.FarmID and SowID = v.SowID and WeekOfDate = v.WeekOfDate),
		AdjDaysRemove = IsNull(datediff(day, v.WeekOfDate-1, (SELECT RemovalDate FROM dbo.Sow Where FarmID = v.FarmID and SowID = v.SowID and RemovalDate <= (v.WeekOfDate+6))),0),
		RemoveDate = (SELECT RemovalDate FROM dbo.Sow Where FarmID = v.FarmID and SowID = v.SowID)
		FROM dbo.vPM_TotalSowDaysBase v
		WHERE SowID Not In(SELECT Distinct SowID FROM dbo.SowMatingEvent 
			Where FarmID = v.FarmID and SowID = v.SowID and WeekOfDate < v.WeekOfDate)

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_UnbredGiltDaysBase] TO [se\analysts]
    AS [dbo];


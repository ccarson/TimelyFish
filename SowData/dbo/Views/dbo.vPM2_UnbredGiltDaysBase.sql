CREATE VIEW [vPM2_UnbredGiltDaysBase]
	As
	SELECT v.FarmID, v.SowID, v.WeekOfDate, v.SowGenetics, v.SowParity, v.SowDays, 
		AdjDaysMating = IsNull(datediff(day, v.WeekOfDate-1, (SELECT Min(EventDate) FROM SowMatingEventTemp Where FarmID = v.FarmID and SowID = v.SowID and WeekOfDate = v.WeekOfDate)),0),
		FirstMatingDate = (SELECT Min(EventDate) FROM SowMatingEventTemp Where FarmID = v.FarmID and SowID = v.SowID and WeekOfDate = v.WeekOfDate),
		AdjDaysRemove = IsNull(datediff(day, v.WeekOfDate-1, (SELECT RemovalDate FROM SowTemp Where FarmID = v.FarmID and SowID = v.SowID and RemovalDate <= (v.WeekOfDate+6))),0),
		RemoveDate = (SELECT RemovalDate FROM SowTemp Where FarmID = v.FarmID and SowID = v.SowID)
		FROM vPM2_TotalSowDaysBase v WITH (NOLOCK)
		WHERE SowID Not In(SELECT Distinct SowID FROM SowMatingEventTemp 
			Where FarmID = v.FarmID and SowID = v.SowID and WeekOfDate < v.WeekOfDate)


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_UnbredGiltDaysBase] TO [se\analysts]
    AS [dbo];


CREATE VIEW vSowInventoryEvent 	
	AS 	
	SELECT l.FarmID, wk.WeekOfDate, l.SowID, l.SowParity,
	 BornAlive=(Select (isnull(Qty,0)) from vPM_PigsBornAliveTemp where SowID=l.SowID and SowParity=l.SowParity and WeekOfDate=wk.WeekOfDate),
	 PigDeath=(Select (isnull(Qty,0)) from vPM_PigsDeathTemp where SowID=l.SowID and SowParity=l.SowParity and WeekOfDate=wk.WeekOfDate),
	 CalcPigDeath=(Select (isnull(Qty,0)) from vPM_CalcPigsDeathTemp where SowID=l.SowID and SowParity=l.SowParity and WeekOfDate=wk.WeekOfDate),
	 Wean=(Select (isnull(Qty,0)) from vPM_PigsWeanedTemp where SowID=l.SowID and SowParity=l.SowParity and WeekOfDate=wk.WeekOfDate)
from vLactationDayDetail l
JOIN WeekDefinitionTemp wk on l.DayDate=wk.WeekEndDate

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowInventoryEvent] TO [se\analysts]
    AS [dbo];


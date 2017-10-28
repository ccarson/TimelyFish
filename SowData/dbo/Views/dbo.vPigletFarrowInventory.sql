CREATE VIEW vPigletFarrowInventory 	
	(FarmID, WeekOfDate, SowID, SowParity, Qty)
	AS 	
SELECT l.FarmID, wk.WeekOfDate, l.SowID, l.SowParity,
	sum(isnull(ba.Qty,0)+isnull(n.Qty,0)-isnull(d.Qty,0)-isnull(w.Qty,0))
from vLactationDayDetail l
JOIN WeekDefinitionTemp wk on l.DayDate=wk.WeekEndDate
LEFT JOIN  vPM_PigsBornAliveTemp ba on l.SowID=ba.SowID and l.SowParity=ba.SowParity and ba.WeekOfDate<=wk.WeekOfDate
LEFT JOIN vPM_PigsNursedOnTemp n on l.SowID=n.SowID and l.SowParity=n.SowParity and n.WeekOfDate<=wk.WeekOfDate
LEFT JOIN vPM_PigsDeathTemp d on l.SowID=d.SowID and l.SowParity=d.SowParity and d.WeekOfDate<=wk.WeekOfDate
LEFT JOIN vPM_PigsWeanedTemp w on l.SowID=w.SowID and l.SowParity=w.SowParity and w.WeekOfDate<=wk.WeekOfDate

GROUP BY l.FarmID, wk.WeekOfDate, l.SowID, l.SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPigletFarrowInventory] TO [se\analysts]
    AS [dbo];


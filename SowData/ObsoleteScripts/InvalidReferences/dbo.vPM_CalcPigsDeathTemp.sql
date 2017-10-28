CREATE VIEW [dbo].[vPM_CalcPigsDeathTemp] (FarmID, WeekOfDate, SowID, SowParity, Qty)
	As
 SELECT w.FarmID, w.WeekOfDate, w.SowID, w.SowParity, ba.QtyBornAlive-Sum(w.Qty)
	FROM dbo.SowFarrowEventTemp ba 
	JOIN dbo.vPM_LastWeaningsBase w on ba.SowID=w.SowID and ba.SowParity=w.SowParity
	Group By w.FarmID, w.WeekOfDate, w.SowID, w.SowParity,ba.QtyBornAlive

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_CalcPigsDeathTemp] TO [se\analysts]
    AS [dbo];


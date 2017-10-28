

CREATE VIEW [dbo].[vPM_PigsBornAlive] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowGenetics, SowParity, sum(QtyBornAlive)
	FROM caredata.cfv_SowFarrowEvent 
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity



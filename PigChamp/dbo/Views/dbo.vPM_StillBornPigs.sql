

CREATE VIEW [dbo].[vPM_StillBornPigs] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowGenetics, SowParity, sum(QtyStillBorn)
	FROM caredata.cfv_SowFarrowEvent 
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity



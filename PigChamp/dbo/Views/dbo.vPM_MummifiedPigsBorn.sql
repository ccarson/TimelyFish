

CREATE VIEW [dbo].[vPM_MummifiedPigsBorn] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowGenetics, SowParity, sum(QtyMummy) 
	FROM caredata.cfv_SowFarrowEvent 
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity



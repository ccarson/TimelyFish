



CREATE VIEW [dbo].[vPM_SowsFarrowed] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowGenetics, SowParity, count(*)
	FROM caredata.cfv_SowFarrowEvent
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity





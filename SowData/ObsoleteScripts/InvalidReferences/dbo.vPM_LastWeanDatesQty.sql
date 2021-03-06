﻿CREATE view [dbo].[vPM_LastWeanDatesQty] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
	--  Count of Sows with last wean date in period
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
	FROM dbo.vPM_LastWeaningsBase
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_LastWeanDatesQty] TO [se\analysts]
    AS [dbo];


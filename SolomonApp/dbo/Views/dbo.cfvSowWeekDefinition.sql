


--*************************************************************
--	Purpose:Kronos Week Definition
--	Author: Sue Matter
--	Date: 12/7/2006
--	Usage: Kronos Week Definition Sow Extract		 
--	Parms: 
-- 2015-01-13 change to use the solomonapp table, sowdata.dbo.weekdefinition, is now a view point to same definition.
--*************************************************************

CREATE VIEW [dbo].[cfvSowWeekDefinition]

AS

Select WeekOfDate, WeekEndDate, PICYear, PICWeek, FiscalYear, FiscalPeriod
FROM solomonapp.dbo.cftWeekDefinition NOLOCK

--Select * 
--FROM SowData.dbo.WeekDefinition NOLOCK	-- removed the saturn reference 201310



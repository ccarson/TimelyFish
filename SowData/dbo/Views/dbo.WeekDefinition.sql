

--*************************************************************
--	Purpose: Sowdata Week Definition
--	Author: SRipley
--	Date: 1/12/2015
--	Usage: teleforms		 
--	Parms: 
--*************************************************************

CREATE VIEW [dbo].[WeekDefinition]

AS
Select WeekOfDate, WeekEndDate, PICYear, PICWeek, FiscalYear, FiscalPeriod
FROM [$(SolomonApp)].dbo.cftWeekDefinition NOLOCK



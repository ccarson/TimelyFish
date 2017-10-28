
--*************************************************************
--	Purpose:Pig Group Transaction Final
--		
--	Author: Charity Anderson
--	Date: 7/15/2005
--	Usage: EssBase 
--	Parms: None
--*************************************************************

CREATE VIEW dbo.vCFPigGroupTransaction
AS
Select Right(rtrim(wd.PICYear),2) + 'WK' + 
	replicate('0',2-len(rtrim(convert(char(2),rtrim(wd.PICWeek)))))
	 			+ rtrim(convert(char(2),rtrim(wd.PICWeek))) as Week,
	pg.TaskID as PigGroup,
	'Actual' as Scenerio,
	Account,
	sum(Value) as Value
FROM vCFPigGroupTranUNION tu
JOIN cftPigGroup pg on tu.PigGroupID=pg.PigGroupID
JOIN cftWeekDefinition wd on pg.ActCloseDate between wd.WeekOfDate and wd.WeekEndDate
WHERE pg.PGStatusID in ('X','I')
Group by PICYear,PICWeek,pg.TaskID,Account

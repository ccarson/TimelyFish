create procedure [dbo].[cfp_EssbaseEventTemp_remove]
	AS
	-- CLEAR OUT THE TEMPORARY TABLES
	TRUNCATE TABLE SowFarrowEventTemp
	TRUNCATE TABLE SowMatingEventTemp
	truncate table SowPigletDeathEventTemp
	TRUNCATE TABLE SowweanEventTemp
	TRUNCATE TABLE SownurseEventTemp
	truncate table  dbo.EssbaseUploadTemp 
 


INSERT INTO SowFarrowEventTemp
		SELECT distinct event_id, farmid, sowid, eventdate, weekofdate, qtybornalive, qtystillborn, qtymummy, induced, assisted, sowparity, sowgenetics, null 
		FROM [$(PigCHAMP)].caredata.cfv_SowFarrowEvent WHERE EventDate >=  
			(select min(weekofdate) from weekdefinitiontemp)


Begin Transaction
--Insert all transport records for the date range user selected
	INSERT INTO SowMatingEventTemp
		SELECT eventid, farmid, sowid, matingtype, eventdate, weekofdate, semenid, observer, hourflag, matingnbr, sowparity, sowgenetics, null
		 FROM [$(PigCHAMP)].caredata.cfv_SowMatingEvent WHERE EventDate >=  
			(select min(weekofdate) from weekdefinitiontemp)
		 
Commit

Begin Transaction
	INSERT INTO SowweanEventTemp
		SELECT eventid, farmid, sowid, eventtype, eventdate, weekofdate, qty, sowparity, sowgenetics, null 
		FROM [$(PigCHAMP)].caredata.cfv_SowweanEvent WHERE EventDate >=  (select min(weekofdate) from weekdefinitiontemp)
Commit

Begin Transaction
	INSERT INTO SownurseEventTemp
		SELECT eventid, farmid, sowid, eventtype, eventdate, weekofdate, qty, sowparity, sowgenetics, null 
		FROM [$(PigCHAMP)].caredata.cfv_SownurseEvent WHERE EventDate >=  (select min(weekofdate) from weekdefinitiontemp)
Commit

Begin Transaction
	insert into SowPigletDeathEventTemp
		select eventid, farmid, sowid, eventdate, weekofdate, qty, reason, sowparity, sowgenetics, null
		from [$(PigCHAMP)].caredata.cfv_SowPigletDeathEvent
Commit

Begin Transaction
INSERT INTO dbo.EssbaseUploadTemp (FarmID, WeekOfDate, Genetics, Parity, PICWeek, PICYear, FiscalPeriod, FiscalYear, Account, Qty)
	SELECT v.FarmID, v.WeekOfDate, v.SowGenetics, v.SowParity,  wd.PICWeek,wd.PICYear,wd.FiscalPeriod,wd.FiscalYear,'AdjServedToFarrow',v.Qty
	FROM vPM2_AdjServedToFarrow v
	JOIN WeekDefinitionTemp wd ON v.WeekOfDate = wd.WeekOfDate
	order by farmid, sowgenetics, sowparity
Commit

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_EssbaseEventTemp_remove] TO [db_sp_exec]
    AS [dbo];


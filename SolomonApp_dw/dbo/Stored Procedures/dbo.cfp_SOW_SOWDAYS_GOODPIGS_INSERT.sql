



-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 12/9/2010
-- Description:	Populates table in data warehouse.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_SOW_SOWDAYS_GOODPIGS_INSERT]
AS
BEGIN

-------------------------------------------------------------------------------------------------------
-- this is dependent on replication finishing, so should be run directly after log shipping completes
-------------------------------------------------------------------------------------------------------
--clear table for new data
TRUNCATE TABLE  dbo.cft_SOW_SOWDAYS_GOODPIGS

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
INSERT INTO  dbo.cft_SOW_SOWDAYS_GOODPIGS
(	ContactID
	,WeekOfDate
	,GoodPigs
	,SowDays)
	
	Select
	
	FS.ContactID,
	WD.WeekOfDate,
	GP.GoodPigs, 
	Sum(SD.SowDays) as SowDays
	
	from  dbo.cfv_TOTAL_SOW_DAYS_BASE SD (nolock)
	
--	left join SaturnSowData.dbo.FarmSetup FS -- removed the saturn_reference 20130905 as part of the saturn_retirement
	left join earth.SowData.dbo.FarmSetup FS
	on SD.FarmID = FS.FarmID
	
	left join [$(SolomonApp)].dbo.cftWeekDefinition WD (nolock)
	on SD.WeekOfDate = WD.WeekOfDate
	
	left join 
	(Select Case when ContactID = 341 then 340 
	when ContactID = 343 then 342 
	when ContactID = 346 then 345
	when ContactID = 348 then 347
	when ContactID = 350 then 349 else ContactID end ContactID, PIC_Week, Sum(GoodPigs) GoodPigs
	from [$(SolomonApp)].dbo.cfvSowFarmPigs (nolock)
	Group by ContactID, PIC_Week) GP 
	on GP.ContactID = FS.ContactID
	and GP.PIC_Week = right(WD.PICYear,2) + 'WK' + 
	replicate('0',2-len(rtrim(convert(char(2),rtrim(WD.PICWeek))))) + rtrim(convert(char(2),rtrim(wd.PICWeek)))

	Where WD.FiscalYear >= 2008
	
	Group by
	FS.ContactID,
	GP.GoodPigs,
	WD.WeekOfDate,
	WD.FiscalPeriod,
	WD.FiscalYear

	Order by
	FS.ContactID,
	WD.WeekOfDate
	
END





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_SOWDAYS_GOODPIGS_INSERT] TO [db_sp_exec]
    AS [dbo];






CREATE PROC [dbo].[pBuildEssbasePigsBornforFarrowedAndWeaned_WO_remove]
	@startdate datetime
	AS
	Declare @AcctName varchar(30)	
	/* This procedures loads the Essbase temporary table - this table is used in VB to create
	    the actuall exported text file that Essbase can then upload     */
	SET NOCOUNT ON
	
	-- Extract PigsBornforFarrowedAndWeaned
	BEGIN TRANSACTION
	Select @AcctName = 'PigsBornforFarrowedAndWeaned'
	INSERT INTO dbo.EssbaseUploadTemp(FarmID, WeekOfDate, Genetics, Parity, PICWeek, PICYear, FiscalPeriod, FiscalYear, Account, Qty)
	SELECT v.FarmID, v.WeekOfDate, v.SowGenetics, v.SowParity,  wd.PICWeek,wd.PICYear,wd.FiscalPeriod,wd.FiscalYear,@AcctName,v.Qty
	FROM vPM2_PigsBornforFarrowedAndWeaned v
	JOIN WeekDefinitionTemp wd ON v.WeekOfDate = wd.WeekOfDate
	where v.WeekOfDate >= @startdate
	COMMIT WORK
	
	-- TURN BACK ON SQL's returning of affected row count
	SET NOCOUNT OFF





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pBuildEssbasePigsBornforFarrowedAndWeaned_WO_remove] TO [db_sp_exec]
    AS [dbo];


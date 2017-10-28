


CREATE PROC [dbo].[pBuildEssbasePigletDeaths_WO_remove]
	@startdate datetime
	AS
	Declare @AcctName varchar(30)	
	/* This procedures loads the Essbase temporary table - this table is used in VB to create
	    the actuall exported text file that Essbase can then upload     */
	SET NOCOUNT ON

	-- Extract PigletDeaths
	BEGIN TRANSACTION
	Select @AcctName = 'PigletDeaths'
	INSERT INTO dbo.EssbaseUploadTemp (FarmID, WeekOfDate, Genetics, Parity, PICWeek, PICYear, FiscalPeriod, FiscalYear, Account, Qty)
	SELECT v.FarmID, v.WeekOfDate, v.SowGenetics, v.SowParity,  wd.PICWeek,wd.PICYear,wd.FiscalPeriod,wd.FiscalYear,@AcctName,v.Qty
	FROM vPM2_PigletDeaths v
	JOIN WeekDefinitionTemp wd ON v.WeekOfDate = wd.WeekOfDate
	where v.WeekOfDate >= @startdate
	COMMIT WORK

	SET NOCOUNT OFF




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pBuildEssbasePigletDeaths_WO_remove] TO [db_sp_exec]
    AS [dbo];


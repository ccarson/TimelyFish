




CREATE PROC [dbo].[cfp_BuildEssbasePigletDeaths_WO]

	AS
	Declare @AcctName varchar(30)	
	/* This procedures loads the Essbase temporary table 
	    the actuall exported text file that Essbase can then upload     */
	SET NOCOUNT ON

	-- Extract PigletDeaths
	BEGIN TRANSACTION
	Select @AcctName = 'PigletDeaths'
	INSERT INTO dbo.EssbaseUploadTemp (FarmID, WeekOfDate, Genetics, Parity, PICWeek, PICYear, FiscalPeriod, FiscalYear, Account, Qty)
	SELECT v.FarmID, v.WeekOfDate, v.SowGenetics, v.SowParity,  wd.PICWeek,wd.PICYear,wd.FiscalPeriod,wd.FiscalYear,@AcctName,v.Qty
	FROM vPM2_PigletDeaths v
	JOIN WeekDefinitionTemp wd ON v.WeekOfDate = wd.WeekOfDate
--	where v.WeekOfDate >= @startdate
	COMMIT WORK

	SET NOCOUNT OFF













CREATE PROC [dbo].[cfp_BuildEssbaseWeanedPigDestQty_WO]

	AS
	Declare @AcctName varchar(30)	
	/* This procedures loads the Essbase temporary table - this table is used in VB to create
	    the actuall exported text file that Essbase can then upload     */
	SET NOCOUNT ON

	-- WeanedPig Destincation Farm Qtys
	BEGIN TRANSACTION  
	Select @AcctName = 'WeanedPigDestQty'
	INSERT INTO dbo.EssbaseUploadTemp (FarmID, WeekOfDate, PICWeek, PICYear, FiscalPeriod, FiscalYear, Account, Qty)
	SELECT v.FarmID, v.WeekOfDate, wd.PICWeek, wd.PICYear,wd.FiscalPeriod,wd.FiscalYear,@AcctName,v.DestQty
	FROM vPM2_TransportPigQtys v
	JOIN WeekDefinitionTemp wd ON v.WeekOfDate = wd.WeekOfDate  -- reduces number of weeks to users request

	COMMIT WORK

	
	-- TURN BACK ON SQL's returning of affected row count
	SET NOCOUNT OFF








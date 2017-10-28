

CREATE PROC [dbo].[pBuildEssbaseUploadTemp64_remove]
	@FarmID varchar(8)
	AS
	Declare @AcctName varchar(30)	
	/* This procedures loads the Essbase temporary table - this table is used in VB to create
	    the actuall exported text file that Essbase can then upload     */
	SET NOCOUNT ON
	--  Transfer Day Qtys - UNCOMMENT AND RECOMPILE WHEN RON/JOHN OKAYS
	-- added 1/11/06 By TJones
	BEGIN TRANSACTION
	Select @AcctName = 'TransferDaysQty'
	INSERT INTO dbo.EssbaseUploadTemp (FarmID, WeekOfDate, Genetics, Parity, PICWeek, PICYear, FiscalPeriod, FiscalYear, Account, Qty)
	SELECT v.FarmID, v.WeekOfDate, v.SowGenetics, v.SowParity, wd.PICWeek, wd.PICYear,wd.FiscalPeriod,wd.FiscalYear,@AcctName,v.Qty
	FROM vPM2_TransferDaysQty v
	JOIN WeekDefinitionTemp wd ON v.WeekOfDate = wd.WeekOfDate  -- reduces number of weeks to users request
	WHERE v.FarmID = @FarmID
	COMMIT WORK

	
	-- TURN BACK ON SQL's returning of affected row count
	SET NOCOUNT OFF


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pBuildEssbaseUploadTemp64_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pBuildEssbaseUploadTemp64_remove] TO [se\analysts]
    AS [dbo];


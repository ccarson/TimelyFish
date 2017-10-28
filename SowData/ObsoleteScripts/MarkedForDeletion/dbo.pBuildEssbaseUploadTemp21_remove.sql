
------------------------------------------------------------------------
-- New procedure for building Essbase temp table - wanted to keep the --
-- old one for now
------------------------------------------------------------------------
CREATE PROC [dbo].[pBuildEssbaseUploadTemp21_remove]
	@FarmID varchar(8)
	AS
	Declare @AcctName varchar(30)	
	/* This procedures loads the Essbase temporary table - this table is used in VB to create
	    the actuall exported text file that Essbase can then upload     */
	SET NOCOUNT ON

   -- Start working through all of the necessary queries

	-- Extract SowsFarrowed
	BEGIN TRANSACTION
	Select @AcctName = 'SowsFarrowed'
	INSERT INTO dbo.EssbaseUploadTemp (FarmID, WeekOfDate, Genetics, Parity, PICWeek, PICYear, FiscalPeriod, FiscalYear, Account, Qty)
	SELECT v.FarmID, v.WeekOfDate, v.SowGenetics, v.SowParity,  wd.PICWeek,wd.PICYear,wd.FiscalPeriod,wd.FiscalYear,@AcctName,v.Qty
	FROM vPM2_SowsFarrowed v
	JOIN WeekDefinitionTemp wd ON v.WeekOfDate = wd.WeekOfDate
	COMMIT WORK
	
	SET NOCOUNT OFF
	

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pBuildEssbaseUploadTemp21_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pBuildEssbaseUploadTemp21_remove] TO [se\analysts]
    AS [dbo];


------------------------------------------------------------------------
-- New procedure for building Essbase temp table - wanted to keep the --
-- old one for now
------------------------------------------------------------------------
CREATE PROC [pBuildEssbaseRemovalUploadTemp_remove]
--	@FarmID varchar(8)
--SJM Changed 8/19/2006
--Run by user date
	@FarmID varchar(8), @parmStart varchar(6), @parmEnd varchar(6)
	AS
	/* This procedures loads the Essbase temporary table - this table is used in VB to create
	    the actuall exported text file that Essbase can then upload     */
	SET NOCOUNT ON
	BEGIN TRANSACTION

	INSERT INTO dbo.EssbaseRemovalUploadTemp 
	(PICWeek,FarmID,SowID, SowParity,RemovalType,RemovalReason,Genetics,FirstService,LastService,RemovalDate,LastWeanDate,
	InitialAge,SowAge,HeadCount,BornAliveQty,MummyQty,StillbornQty,NaturalWeanQty,WeanQty,EntryDate,LastParityServices)
	SELECT PICWeek, SowFarm, FarmSow, SowParity, RemovalType,RemovalReason,GeneticLine,FirstService,
									LastService,RemovalDate,LastWeanDate, InitialAge, SowAge, HeadCount,BornAliveQty, MummyQty, 
									StillbornQty,NaturalWeanQty,WeanQty, EntryDate,NbrLastParityServices
	FROM vRemovalCube_Removals 
--	WHERE SowFarm=@FarmID
	WHERE SowFarm=@FarmID AND PICWeek Between @parmStart and @parmEnd	
	COMMIT WORK
	-- TURN BACK ON SQL's returning of affected row count
	SET NOCOUNT OFF

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pBuildEssbaseRemovalUploadTemp_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pBuildEssbaseRemovalUploadTemp_remove] TO [se\analysts]
    AS [dbo];


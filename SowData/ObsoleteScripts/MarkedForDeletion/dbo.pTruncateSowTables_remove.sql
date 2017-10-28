CREATE PROC [dbo].[pTruncateSowTables_remove]
	As
	-- Stored procedures used by the PigChamp Data extract application
	-- Initial creation date 9/30/02
	-- modifed 6/4/02 to add new tables and change existing table names
	TRUNCATE TABLE dbo.Sow 
	TRUNCATE TABLE dbo.SowParity 
	TRUNCATE TABLE dbo.SowGroupEvent 
	TRUNCATE TABLE dbo.SowLocationEvent 
	TRUNCATE TABLE dbo.SowMatingEvent 
	TRUNCATE TABLE dbo.SowFalloutEvent 
	TRUNCATE TABLE dbo.SowFarrowEvent 
	TRUNCATE TABLE dbo.SowPigletDeathEvent
	TRUNCATE TABLE dbo.SowPregExamEvent 
	TRUNCATE TABLE dbo.SowNonServiceEvent 
	TRUNCATE TABLE dbo.SowNurseEvent 
	TRUNCATE TABLE dbo.SowFosterEvent 
	TRUNCATE TABLE dbo.SowWeanEvent 

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pTruncateSowTables_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pTruncateSowTables_remove] TO [se\analysts]
    AS [dbo];


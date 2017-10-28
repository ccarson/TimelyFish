CREATE PROC [dbo].[pClearGroupTablesSpecificFarm_remove]
	-- Stored procedures used by the PigChamp Sow/Iso group Data extract application
	-- Initial creation date 9/16/05 - TJones

	@FarmID varchar(8)
	As
	SET NOCOUNT ON

	BEGIN TRANSACTION
	DELETE FROM dbo.PCGroup WHERE FarmID = @FarmID
	COMMIT TRANSACTION

	BEGIN TRANSACTION
	DELETE FROM dbo.PCGroupEndEvent WHERE FarmID = @FarmID
	COMMIT TRANSACTION

	BEGIN TRANSACTION
	DELETE FROM dbo.PCGroupInventoryEvent WHERE FarmID = @FarmID
	COMMIT TRANSACTION

	BEGIN TRANSACTION
	DELETE FROM dbo.PCGroupGeneralEvent WHERE FarmID = @FarmID
	COMMIT TRANSACTION

	SET NOCOUNT OFF

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pClearGroupTablesSpecificFarm_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pClearGroupTablesSpecificFarm_remove] TO [se\analysts]
    AS [dbo];


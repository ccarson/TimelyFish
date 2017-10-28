CREATE PROC [dbo].[pClearUploadTablesSpecificFarm_remove]
	@FarmID varchar(8)
	As
	SET NOCOUNT ON

	BEGIN TRANSACTION
		Delete from pcuploadformheader where FarmID=@FarmID
	COMMIT TRANSACTION
	BEGIN TRANSACTION
	DELETE from PCUploadBoarAddition where FarmID=@FarmID
	COMMIT TRANSACTION
	BEGIN TRANSACTION
	DELETE from PCUploadBreedStockAddition where FarmID=@FarmID
	COMMIT TRANSACTION
	BEGIN TRANSACTION
	DELETE from PCUploadBreedStockRemoval where FarmID=@FarmID
	COMMIT TRANSACTION
	BEGIN TRANSACTION
	DELETE from PCUploadBreedTransaction where FarmID=@FarmID
	COMMIT TRANSACTION
	BEGIN TRANSACTION
	DELETE from PCUploadMasterBreed where FarmID=@FarmID
	COMMIT TRANSACTION
	BEGIN TRANSACTION
	DELETE from PCUploadMasterFarrow where FarmID=@FarmID
	COMMIT TRANSACTION
	BEGIN TRANSACTION
	DELETE from PCUploadMasterWean where FarmID=@FarmID
	COMMIT TRANSACTION
	BEGIN TRANSACTION
	DELETE from PCUploadPigMortCrossFoster where FarmID=@FarmID
	COMMIT TRANSACTION
SET NOCOUNT OFF

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pClearUploadTablesSpecificFarm_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pClearUploadTablesSpecificFarm_remove] TO [se\analysts]
    AS [dbo];


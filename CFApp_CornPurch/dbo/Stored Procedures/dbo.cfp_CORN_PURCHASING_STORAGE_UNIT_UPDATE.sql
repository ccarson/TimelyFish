
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Updates the StorageUnit record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_STORAGE_UNIT_UPDATE]
(
    @StorageUnitID	int,
    @FeedMillID	varchar(10),
    @Name	varchar(50),
    @StorageTypeID	int,
    @StorageCapacity	int,
    @Description	varchar(100),
    @Active	bit,
    @UpdatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_STORAGE_UNIT SET
    [FeedMillID] = @FeedMillID,
    [Name] = @Name,
    [StorageTypeID] = @StorageTypeID,
    [StorageCapacity] = @StorageCapacity,
    [Description] = @Description,
    [Active] = @Active,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE StorageUnitID = @StorageUnitID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_STORAGE_UNIT_UPDATE] TO [db_sp_exec]
    AS [dbo];


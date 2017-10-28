
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Creates new StorageUnit record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_STORAGE_UNIT_INSERT]
(
    @StorageUnitID	int	OUT,
    @FeedMillID	varchar(10),
    @Name	varchar(50),
    @StorageTypeID	int,
    @StorageCapacity	int,
    @Description	varchar(100),
    @Active	bit,
    @CreatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_STORAGE_UNIT
  (
      [FeedMillID],
      [Name],
      [StorageTypeID],
      [StorageCapacity],
      [Description],
      [Active],
      [CreatedBy]
  )
  VALUES
  (
      @FeedMillID,
      @Name,
      @StorageTypeID,
      @StorageCapacity,
      @Description,
      @Active,
      @CreatedBy
  )

  SELECT @StorageUnitID = StorageUnitID
  FROM dbo.cft_STORAGE_UNIT
  WHERE StorageUnitID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_STORAGE_UNIT_INSERT] TO [db_sp_exec]
    AS [dbo];


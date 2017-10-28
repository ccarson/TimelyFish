
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects StorageUnit record by id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_STORAGE_UNIT_SELECT_BY_ID]
(
    @StorageUnitID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [FeedMillID],
       [Name],
       [StorageTypeID],
       [StorageCapacity],
       [Description],
       [Active],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_STORAGE_UNIT
WHERE StorageUnitID = @StorageUnitID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_STORAGE_UNIT_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];



-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects all StorageUnit records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_STORAGE_UNIT_SELECT]
AS
BEGIN
SET NOCOUNT ON;

SELECT [StorageUnitID],
       [FeedMillID],
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
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_STORAGE_UNIT_SELECT] TO [db_sp_exec]
    AS [dbo];


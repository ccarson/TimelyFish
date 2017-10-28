
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects all GpaForeignMaterialDetail records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_DETAIL_SELECT]
AS
BEGIN
SET NOCOUNT ON;

SELECT [GPAForeignMaterialDetailID],
       [GPAForeignMaterialID],
       [Increment],
       [RangeFrom],
       [RangeTo],
       [Value],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_GPA_FOREIGN_MATERIAL_DETAIL
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_DETAIL_SELECT] TO [db_sp_exec]
    AS [dbo];


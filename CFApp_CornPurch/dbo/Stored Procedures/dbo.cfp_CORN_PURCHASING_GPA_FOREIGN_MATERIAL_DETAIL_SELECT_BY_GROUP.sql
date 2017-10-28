
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects GpaForeignMaterialDetail record by group id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_DETAIL_SELECT_BY_GROUP]
(
    @GPAForeignMaterialID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [GPAForeignMaterialDetailID],
       [Increment],
       [RangeFrom],
       [RangeTo],
       [Value],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_GPA_FOREIGN_MATERIAL_DETAIL
WHERE GPAForeignMaterialID = @GPAForeignMaterialID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_DETAIL_SELECT_BY_GROUP] TO [db_sp_exec]
    AS [dbo];


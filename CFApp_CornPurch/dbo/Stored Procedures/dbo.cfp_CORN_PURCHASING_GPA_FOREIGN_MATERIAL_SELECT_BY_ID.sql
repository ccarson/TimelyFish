
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects GpaForeignMaterial record by id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_SELECT_BY_ID]
(
    @GPAForeignMaterialID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [FeedMillID],
       [EffectiveDateFrom],
       [EffectiveDateTo],
       [Default],
       [Active],
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_GPA_FOREIGN_MATERIAL
WHERE GPAForeignMaterialID = @GPAForeignMaterialID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];


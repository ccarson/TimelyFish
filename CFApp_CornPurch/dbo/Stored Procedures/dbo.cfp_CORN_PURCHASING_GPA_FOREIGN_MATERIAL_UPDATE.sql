
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Updates the GpaForeignMaterial record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_UPDATE]
(
    @GPAForeignMaterialID	int,
    @FeedMillID	varchar(10),
    @EffectiveDateFrom	datetime,
    @EffectiveDateTo	datetime,
    @Default	bit,
    @Active	bit,
    @UpdatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_GPA_FOREIGN_MATERIAL SET
    [FeedMillID] = @FeedMillID,
    [EffectiveDateFrom] = @EffectiveDateFrom,
    [EffectiveDateTo] = @EffectiveDateTo,
    [Default] = @Default,
    [Active] = @Active,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE GPAForeignMaterialID = @GPAForeignMaterialID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_UPDATE] TO [db_sp_exec]
    AS [dbo];


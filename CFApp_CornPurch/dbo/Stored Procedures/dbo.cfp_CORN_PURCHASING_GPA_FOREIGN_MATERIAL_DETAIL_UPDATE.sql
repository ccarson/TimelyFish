
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Updates the GpaForeignMaterialDetail record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_DETAIL_UPDATE]
(
    @GPAForeignMaterialDetailID	int,
    @GPAForeignMaterialID	int,
    @Increment	money,
    @RangeFrom	money,
    @RangeTo	money,
    @Value	decimal(14,6),
    @UpdatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_GPA_FOREIGN_MATERIAL_DETAIL SET
    [GPAForeignMaterialID] = @GPAForeignMaterialID,
    [Increment] = @Increment,
    [RangeFrom] = @RangeFrom,
    [RangeTo] = @RangeTo,
    [Value] = @Value,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE GPAForeignMaterialDetailID = @GPAForeignMaterialDetailID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_DETAIL_UPDATE] TO [db_sp_exec]
    AS [dbo];



-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Creates new GpaForeignMaterialDetail record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_DETAIL_INSERT]
(
    @GPAForeignMaterialDetailID	int	OUT,
    @GPAForeignMaterialID	int,
    @Increment	money,
    @RangeFrom	money,
    @RangeTo	money,
    @Value	decimal(14,6),
    @CreatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_GPA_FOREIGN_MATERIAL_DETAIL
  (
      [GPAForeignMaterialID],
      [Increment],
      [RangeFrom],
      [RangeTo],
      [Value],
      [CreatedBy]
  )
  VALUES
  (
      @GPAForeignMaterialID,
      @Increment,
      @RangeFrom,
      @RangeTo,
      @Value,
      @CreatedBy
  )

  SELECT @GPAForeignMaterialDetailID = GPAForeignMaterialDetailID
  FROM dbo.cft_GPA_FOREIGN_MATERIAL_DETAIL
  WHERE GPAForeignMaterialDetailID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_FOREIGN_MATERIAL_DETAIL_INSERT] TO [db_sp_exec]
    AS [dbo];


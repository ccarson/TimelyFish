
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Creates new GpaTestWeightDetail record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_TEST_WEIGHT_DETAIL_INSERT]
(
    @GPATestWeightDetailID	int	OUT,
    @GPATestWeightID	int,
    @Increment	money,
    @RangeFrom	money,
    @RangeTo	money,
    @Value	decimal(14,6),
    @CreatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_GPA_TEST_WEIGHT_DETAIL
  (
      [GPATestWeightID],
      [Increment],
      [RangeFrom],
      [RangeTo],
      [Value],
      [CreatedBy]
  )
  VALUES
  (
      @GPATestWeightID,
      @Increment,
      @RangeFrom,
      @RangeTo,
      @Value,
      @CreatedBy
  )

  SELECT @GPATestWeightDetailID = GPATestWeightDetailID
  FROM dbo.cft_GPA_TEST_WEIGHT_DETAIL
  WHERE GPATestWeightDetailID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_TEST_WEIGHT_DETAIL_INSERT] TO [db_sp_exec]
    AS [dbo];


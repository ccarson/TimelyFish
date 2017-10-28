
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Creates new GpaMoistureValuation record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_VALUATION_INSERT]
(
    @GPAMoistureValuationID	int	OUT,
    @FeedMillID	varchar(10),
    @GPAMoistureValuationMethodID	int,
    @EffectiveDateFrom	datetime,
    @EffectiveDateTo	datetime,
    @Default	bit,
    @Active	bit,
    @CreatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_GPA_MOISTURE_VALUATION
  (
      [FeedMillID],
      [GPAMoistureValuationMethodID],
      [EffectiveDateFrom],
      [EffectiveDateTo],
      [Default],
      [Active],
      [CreatedBy]
  )
  VALUES
  (
      @FeedMillID,
      @GPAMoistureValuationMethodID,
      @EffectiveDateFrom,
      @EffectiveDateTo,
      @Default,
      @Active,
      @CreatedBy
  )

  SELECT @GPAMoistureValuationID = GPAMoistureValuationID
  FROM dbo.cft_GPA_MOISTURE_VALUATION
  WHERE GPAMoistureValuationID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_VALUATION_INSERT] TO [db_sp_exec]
    AS [dbo];


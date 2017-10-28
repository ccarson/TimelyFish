
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Creates new GpaMoistureCharge record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_CHARGE_INSERT]
(
    @GPAMoistureChargeID	int	OUT,
    @FeedMillID	varchar(10),
    @EffectiveDateFrom	datetime,
    @EffectiveDateTo	datetime,
    @Default	bit,
    @Active	bit,
    @CreatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_GPA_MOISTURE_CHARGE
  (
      [FeedMillID],
      [EffectiveDateFrom],
      [EffectiveDateTo],
      [Default],
      [Active],
      [CreatedBy]
  )
  VALUES
  (
      @FeedMillID,
      @EffectiveDateFrom,
      @EffectiveDateTo,
      @Default,
      @Active,
      @CreatedBy
  )

  SELECT @GPAMoistureChargeID = GPAMoistureChargeID
  FROM dbo.cft_GPA_MOISTURE_CHARGE
  WHERE GPAMoistureChargeID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_CHARGE_INSERT] TO [db_sp_exec]
    AS [dbo];


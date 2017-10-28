
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Creates new GpaDryingCharge record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_DRYING_CHARGE_INSERT]
(
    @GPADryingChargeID	int	OUT,
    @GPAMoistureValuationMethodID	int,
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

  INSERT dbo.cft_GPA_DRYING_CHARGE
  (
      [GPAMoistureValuationMethodID],
      [FeedMillID],
      [EffectiveDateFrom],
      [EffectiveDateTo],
      [Default],
      [Active],
      [CreatedBy]
  )
  VALUES
  (
      @GPAMoistureValuationMethodID,
      @FeedMillID,
      @EffectiveDateFrom,
      @EffectiveDateTo,
      @Default,
      @Active,
      @CreatedBy
  )

  SELECT @GPADryingChargeID = GPADryingChargeID
  FROM dbo.cft_GPA_DRYING_CHARGE
  WHERE GPADryingChargeID = SCOPE_IDENTITY()

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_DRYING_CHARGE_INSERT] TO [db_sp_exec]
    AS [dbo];


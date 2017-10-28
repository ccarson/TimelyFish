
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Updates the GpaTestWeight record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_TEST_WEIGHT_UPDATE]
(
    @GPATestWeightID	int,
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

  UPDATE dbo.cft_GPA_TEST_WEIGHT SET
    [FeedMillID] = @FeedMillID,
    [EffectiveDateFrom] = @EffectiveDateFrom,
    [EffectiveDateTo] = @EffectiveDateTo,
    [Default] = @Default,
    [Active] = @Active,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE GPATestWeightID = @GPATestWeightID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_TEST_WEIGHT_UPDATE] TO [db_sp_exec]
    AS [dbo];


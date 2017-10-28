
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Updates the GpaShrinkDeduction record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_SHRINK_DEDUCTION_UPDATE]
(
    @GPAShrinkDeductionID	int,
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

  UPDATE dbo.cft_GPA_SHRINK_DEDUCTION SET
    [FeedMillID] = @FeedMillID,
    [EffectiveDateFrom] = @EffectiveDateFrom,
    [EffectiveDateTo] = @EffectiveDateTo,
    [Default] = @Default,
    [Active] = @Active,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE GPAShrinkDeductionID = @GPAShrinkDeductionID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_SHRINK_DEDUCTION_UPDATE] TO [db_sp_exec]
    AS [dbo];


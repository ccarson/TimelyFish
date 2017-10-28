
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Updates the GpaMoistureValuation record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_VALUATION_UPDATE]
(
    @GPAMoistureValuationID	int,
    @FeedMillID	varchar(10),
    @GPAMoistureValuationMethodID	int,
    @EffectiveDateFrom	datetime,
    @EffectiveDateTo	datetime,
    @Default	bit,
    @Active	bit,
    @UpdatedBy	varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  UPDATE dbo.cft_GPA_MOISTURE_VALUATION SET
    [FeedMillID] = @FeedMillID,
    [GPAMoistureValuationMethodID] = @GPAMoistureValuationMethodID,
    [EffectiveDateFrom] = @EffectiveDateFrom,
    [EffectiveDateTo] = @EffectiveDateTo,
    [Default] = @Default,
    [Active] = @Active,
    [UpdatedBy] = @UpdatedBy,
    UpdatedDateTime = getdate()
  WHERE GPAMoistureValuationID = @GPAMoistureValuationID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_VALUATION_UPDATE] TO [db_sp_exec]
    AS [dbo];


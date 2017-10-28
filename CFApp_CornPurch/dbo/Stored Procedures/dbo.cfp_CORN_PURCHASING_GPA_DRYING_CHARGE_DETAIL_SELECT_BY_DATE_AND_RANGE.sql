
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects GpaDryingChargeDetail record by date,range and feed mill id
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_GPA_DRYING_CHARGE_DETAIL_SELECT_BY_DATE_AND_RANGE
(
    @GPAMoistureValuationMethodID	int,
    @Date				datetime,
    @Range				decimal(5,2),
    @FeedMillID				char(10)
)
AS
BEGIN
SET NOCOUNT ON;


IF EXISTS (SELECT 1
           FROM dbo.cft_GPA_DRYING_CHARGE_DETAIL DCD
           INNER JOIN dbo.cft_GPA_DRYING_CHARGE DC ON DC.GPADryingChargeID = DCD.GPADryingChargeID
           WHERE DC.Active = 1 
                 AND DC.[Default] = 0 
                 AND DC.FeedMillID = @FeedMillID
                 AND @Date BETWEEN DC.EffectiveDateFrom AND DC.EffectiveDateTo
                 AND DC.GPAMoistureValuationMethodID = @GPAMoistureValuationMethodID
                 AND @Range BETWEEN DCD.RangeFrom AND DCD.RangeTo
          )
BEGIN
  
SELECT DCD.[GPADryingChargeDetailID],
       DCD.[GPADryingChargeID],
       DCD.[Increment],
       DCD.[RangeFrom],
       DCD.[RangeTo],
       DCD.[Value],
       DCD.[CreatedDateTime],
       DCD.[CreatedBy],
       DCD.[UpdatedDateTime],
       DCD.[UpdatedBy]
FROM dbo.cft_GPA_DRYING_CHARGE_DETAIL DCD
INNER JOIN dbo.cft_GPA_DRYING_CHARGE DC ON DC.GPADryingChargeID = DCD.GPADryingChargeID
WHERE DC.Active = 1 
      AND DC.[Default] = 0 
      AND DC.FeedMillID = @FeedMillID
      AND @Date BETWEEN DC.EffectiveDateFrom AND DC.EffectiveDateTo
      AND DC.GPAMoistureValuationMethodID = @GPAMoistureValuationMethodID
      AND @Range BETWEEN DCD.RangeFrom AND DCD.RangeTo


END ELSE BEGIN

SELECT DCD.[GPADryingChargeDetailID],
       DCD.[GPADryingChargeID],
       DCD.[Increment],
       DCD.[RangeFrom],
       DCD.[RangeTo],
       DCD.[Value],
       DCD.[CreatedDateTime],
       DCD.[CreatedBy],
       DCD.[UpdatedDateTime],
       DCD.[UpdatedBy]
FROM dbo.cft_GPA_DRYING_CHARGE_DETAIL DCD
INNER JOIN dbo.cft_GPA_DRYING_CHARGE DC ON DC.GPADryingChargeID = DCD.GPADryingChargeID
WHERE DC.Active = 1 
      AND DC.[Default] = 1 
      AND DC.FeedMillID = @FeedMillID
      AND @Date BETWEEN DC.EffectiveDateFrom AND isnull(DC.EffectiveDateTo,'12/31/2099')
      AND DC.GPAMoistureValuationMethodID = @GPAMoistureValuationMethodID
      AND @Range BETWEEN DCD.RangeFrom AND DCD.RangeTo

END


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_DRYING_CHARGE_DETAIL_SELECT_BY_DATE_AND_RANGE] TO [db_sp_exec]
    AS [dbo];



-- =============================================
-- Author:	Andrey Derco
-- Create date: 09/22/2008
-- Description:	Returns drying charge rate for date, moisture value and feed mill
-- =============================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_BY_DATE_AND_RANGE]
(
    @Date				datetime,
    @Range				decimal(5,2),
    @FeedMillID				char(10)
)
RETURNS decimal(18,6)
AS
BEGIN

DECLARE @GPAMoistureValuationMethodID int,
        @Value decimal(14,6)

SET @GPAMoistureValuationMethodID = dbo.cffn_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_FOR_FEED_MILL_AND_DATE(@FeedMillID, @Date)




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
  
SELECT @Value = DCD.[Value]
FROM dbo.cft_GPA_DRYING_CHARGE_DETAIL DCD

INNER JOIN dbo.cft_GPA_DRYING_CHARGE DC ON DC.GPADryingChargeID = DCD.GPADryingChargeID
WHERE DC.Active = 1 
      AND DC.[Default] = 0 
      AND DC.FeedMillID = @FeedMillID
      AND @Date BETWEEN DC.EffectiveDateFrom AND DC.EffectiveDateTo
      AND DC.GPAMoistureValuationMethodID = @GPAMoistureValuationMethodID
      AND @Range BETWEEN DCD.RangeFrom AND DCD.RangeTo


END ELSE BEGIN

SELECT @Value = DCD.[Value]
FROM dbo.cft_GPA_DRYING_CHARGE_DETAIL DCD
INNER JOIN dbo.cft_GPA_DRYING_CHARGE DC ON DC.GPADryingChargeID = DCD.GPADryingChargeID
WHERE DC.Active = 1 
      AND DC.[Default] = 1 
      AND DC.FeedMillID = @FeedMillID
      AND @Date BETWEEN DC.EffectiveDateFrom AND isnull(DC.EffectiveDateTo,'12/31/2099')
      AND DC.GPAMoistureValuationMethodID = @GPAMoistureValuationMethodID
      AND @Range BETWEEN DCD.RangeFrom AND DCD.RangeTo

END

RETURN @Value

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_BY_DATE_AND_RANGE] TO [db_sp_exec]
    AS [dbo];


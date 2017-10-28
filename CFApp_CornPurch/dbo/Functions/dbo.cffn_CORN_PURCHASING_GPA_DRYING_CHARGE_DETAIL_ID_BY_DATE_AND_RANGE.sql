
-- ===================================================================
-- Author:	Nick Honetschlager
-- Create date: 02/20/2015
-- Description:	Returns GpaDryingChargeDetail record by date,range and feed mill id
-- ===================================================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_DETAIL_ID_BY_DATE_AND_RANGE]
(
    @GPAMoistureValuationMethodID	int,
    @Date				datetime,
    @Range				decimal(5,2),
    @FeedMillID				char(10)
)
RETURNS INT
AS
BEGIN

DECLARE @GPADryingChargeDetailID int

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
  
SELECT @GPADryingChargeDetailID = DCD.[GPADryingChargeDetailID]
FROM dbo.cft_GPA_DRYING_CHARGE_DETAIL DCD
INNER JOIN dbo.cft_GPA_DRYING_CHARGE DC ON DC.GPADryingChargeID = DCD.GPADryingChargeID
WHERE DC.Active = 1 
      AND DC.[Default] = 0 
      AND DC.FeedMillID = @FeedMillID
      AND @Date BETWEEN DC.EffectiveDateFrom AND DC.EffectiveDateTo
      AND DC.GPAMoistureValuationMethodID = @GPAMoistureValuationMethodID
      AND @Range BETWEEN DCD.RangeFrom AND DCD.RangeTo

END ELSE BEGIN

SELECT @GPADryingChargeDetailID =  DCD.[GPADryingChargeDetailID]
FROM dbo.cft_GPA_DRYING_CHARGE_DETAIL DCD
INNER JOIN dbo.cft_GPA_DRYING_CHARGE DC ON DC.GPADryingChargeID = DCD.GPADryingChargeID
WHERE DC.Active = 1 
      AND DC.[Default] = 1 
      AND DC.FeedMillID = @FeedMillID
      AND @Date BETWEEN DC.EffectiveDateFrom AND isnull(DC.EffectiveDateTo,'12/31/2099')
      AND DC.GPAMoistureValuationMethodID = @GPAMoistureValuationMethodID
      AND @Range BETWEEN DCD.RangeFrom AND DCD.RangeTo

END

RETURN @GPADryingChargeDetailID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_DETAIL_ID_BY_DATE_AND_RANGE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_DRYING_CHARGE_DETAIL_ID_BY_DATE_AND_RANGE] TO [db_sp_exec]
    AS [dbo];


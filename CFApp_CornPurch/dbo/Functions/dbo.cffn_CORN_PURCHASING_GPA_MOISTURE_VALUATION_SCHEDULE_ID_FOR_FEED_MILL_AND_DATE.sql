
-- =============================================
-- Author:	Nick Honetschlager
-- Create date: 3/3/2015
-- Description:	Returns Moisture valuation schedule ID for feed mill and date.
-- =============================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_GPA_MOISTURE_VALUATION_SCHEDULE_ID_FOR_FEED_MILL_AND_DATE]
(
    @FeedMillID	char(10),
    @Date	datetime
)
RETURNS int
AS
BEGIN

DECLARE @GPAMoistureValuationID int

IF EXISTS (SELECT 1
           FROM dbo.cft_GPA_MOISTURE_VALUATION MV
           WHERE MV.Active = 1 
                 AND MV.[Default] = 0 
                 AND MV.FeedMillID = @FeedMillID
                 AND @Date BETWEEN MV.EffectiveDateFrom AND MV.EffectiveDateTo
          )
BEGIN

SELECT @GPAMoistureValuationID = MV.[GPAMoistureValuationID]
FROM dbo.cft_GPA_MOISTURE_VALUATION MV
WHERE MV.Active = 1 
      AND MV.[Default] = 0 
      AND MV.FeedMillID = @FeedMillID
      AND @Date BETWEEN MV.EffectiveDateFrom AND MV.EffectiveDateTo

END ELSE BEGIN

SELECT @GPAMoistureValuationID = MV.[GPAMoistureValuationID]
FROM dbo.cft_GPA_MOISTURE_VALUATION MV
WHERE MV.Active = 1 
      AND MV.[Default] = 1 
      AND MV.FeedMillID = @FeedMillID
      AND @Date BETWEEN MV.EffectiveDateFrom AND isnull(MV.EffectiveDateTo,'12/31/2050')

END

RETURN @GPAMoistureValuationID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_MOISTURE_VALUATION_SCHEDULE_ID_FOR_FEED_MILL_AND_DATE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_MOISTURE_VALUATION_SCHEDULE_ID_FOR_FEED_MILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];


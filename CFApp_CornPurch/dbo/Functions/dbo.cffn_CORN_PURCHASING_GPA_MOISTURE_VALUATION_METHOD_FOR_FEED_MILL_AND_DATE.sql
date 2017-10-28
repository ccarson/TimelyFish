
-- =============================================
-- Author:	Andrey Derco
-- Create date: 09/22/2008
-- Description:	Returns Moisture valuation method for feed mill and date.
-- =============================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_FOR_FEED_MILL_AND_DATE]
(
    @FeedMillID	char(10),
    @Date	datetime
)
RETURNS decimal(18,4)
AS
BEGIN

DECLARE @GPAMoistureValuationMethodID int



IF EXISTS (SELECT 1
           FROM dbo.cft_GPA_MOISTURE_VALUATION MV
           WHERE MV.Active = 1 
                 AND MV.[Default] = 0 
                 AND MV.FeedMillID = @FeedMillID
                 AND @Date BETWEEN MV.EffectiveDateFrom AND MV.EffectiveDateTo

          )
BEGIN

SELECT @GPAMoistureValuationMethodID = MV.[GPAMoistureValuationMethodID]
FROM dbo.cft_GPA_MOISTURE_VALUATION MV
WHERE MV.Active = 1 
      AND MV.[Default] = 0 
      AND MV.FeedMillID = @FeedMillID
      AND @Date BETWEEN MV.EffectiveDateFrom AND MV.EffectiveDateTo

END ELSE BEGIN

SELECT @GPAMoistureValuationMethodID = MV.[GPAMoistureValuationMethodID]
FROM dbo.cft_GPA_MOISTURE_VALUATION MV
WHERE MV.Active = 1 
      AND MV.[Default] = 1 
      AND MV.FeedMillID = @FeedMillID
      AND @Date BETWEEN MV.EffectiveDateFrom AND isnull(MV.EffectiveDateTo,'12/31/2050')

END

RETURN @GPAMoistureValuationMethodID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_MOISTURE_VALUATION_METHOD_FOR_FEED_MILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];


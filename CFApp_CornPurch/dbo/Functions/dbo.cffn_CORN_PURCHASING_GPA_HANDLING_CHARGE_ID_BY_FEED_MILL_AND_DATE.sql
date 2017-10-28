
-- =============================================================================
-- Author:	Nick Honetschlager
-- Create date: 03/04/2015
-- Description:	Selects GpaHandlingCharge ID by feed mill id and effective dates
-- =============================================================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_GPA_HANDLING_CHARGE_ID_BY_FEED_MILL_AND_DATE]
(
    @FeedMillID	char(10),
    @Date	datetime
)
RETURNS int
BEGIN

DECLARE @GPAHandlingChargeID as int

IF EXISTS (SELECT 1
           FROM dbo.cft_GPA_HANDLING_CHARGE HC
           WHERE HC.Active = 1 
                 AND HC.[Default] = 0 
                 AND HC.FeedMillID = @FeedMillID
                 AND @Date BETWEEN HC.EffectiveDateFrom AND HC.EffectiveDateTo
          )
BEGIN

SELECT @GPAHandlingChargeID = HC.[GPAHandlingChargeID]
FROM dbo.cft_GPA_HANDLING_CHARGE HC
WHERE HC.Active = 1 
      AND HC.[Default] = 0 
      AND HC.FeedMillID = @FeedMillID
      AND @Date BETWEEN HC.EffectiveDateFrom AND HC.EffectiveDateTo

END ELSE BEGIN

SELECT @GPAHandlingChargeID = HC.[GPAHandlingChargeID]
FROM dbo.cft_GPA_HANDLING_CHARGE HC
WHERE HC.Active = 1 
      AND HC.[Default] = 1 
      AND HC.FeedMillID = @FeedMillID
      AND @Date BETWEEN HC.EffectiveDateFrom AND isnull(HC.EffectiveDateTo,'12/31/2050')

END

RETURN @GPAHandlingChargeID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_HANDLING_CHARGE_ID_BY_FEED_MILL_AND_DATE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_HANDLING_CHARGE_ID_BY_FEED_MILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];


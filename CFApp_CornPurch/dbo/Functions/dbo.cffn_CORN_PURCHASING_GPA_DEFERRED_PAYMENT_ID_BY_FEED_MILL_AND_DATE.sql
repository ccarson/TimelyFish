
-- ===================================================================
-- Author:	Nick Honetschlager
-- Create date: 03/09/2015
-- Description:	Selects GpaDeferredPaymentID by feed mill id and effective dates 
-- ===================================================================
CREATE FUNCTION [dbo].[cffn_CORN_PURCHASING_GPA_DEFERRED_PAYMENT_ID_BY_FEED_MILL_AND_DATE]
(
    @FeedMillID	char(10),
    @Date	datetime
)
RETURNS int
BEGIN

DECLARE @GPADeferredPaymentID int

IF EXISTS (SELECT 1 
           FROM dbo.cft_GPA_DEFERRED_PAYMENT 
           WHERE Active = 1 
                 AND [Default] = 0 
                 AND FeedMillID = @FeedMillID
                 AND @Date BETWEEN EffectiveDateFrom AND EffectiveDateTo)   
BEGIN

SELECT @GPADeferredPaymentID = [GPADeferredPaymentID]
FROM dbo.cft_GPA_DEFERRED_PAYMENT 
WHERE Active = 1 
      AND [Default] = 0 
      AND FeedMillID = @FeedMillID
      AND @Date BETWEEN EffectiveDateFrom AND EffectiveDateTo

END ELSE BEGIN

SELECT @GPADeferredPaymentID = [GPADeferredPaymentID]

FROM dbo.cft_GPA_DEFERRED_PAYMENT 
WHERE Active = 1 
      AND [Default] = 1 
      AND FeedMillID = @FeedMillID
      AND @Date BETWEEN EffectiveDateFrom AND isnull(EffectiveDateTo,'12/31/2050')
END

RETURN @GPADeferredPaymentID


END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_DEFERRED_PAYMENT_ID_BY_FEED_MILL_AND_DATE] TO [ApplicationCenter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_CORN_PURCHASING_GPA_DEFERRED_PAYMENT_ID_BY_FEED_MILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];


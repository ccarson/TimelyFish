
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects GpaHandlingCharge record by feed mill id and effective dates
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_GPA_HANDLING_CHARGE_SELECT_BY_FEED_MILL_AND_DATE
(
    @FeedMillID	char(10),
    @Date	datetime
)
AS
BEGIN
SET NOCOUNT ON;


IF EXISTS (SELECT 1
           FROM dbo.cft_GPA_HANDLING_CHARGE HC
           WHERE HC.Active = 1 
                 AND HC.[Default] = 0 
                 AND HC.FeedMillID = @FeedMillID
                 AND @Date BETWEEN HC.EffectiveDateFrom AND HC.EffectiveDateTo
          )
BEGIN

SELECT HC.[GPAHandlingChargeID],
       HC.[HandlingCharge],
       HC.[EffectiveDateFrom],
       HC.[EffectiveDateTo],
       HC.[FreeDelayedPricingLength],
       HC.[ChargesBeginDate],
       HC.[Default],
       HC.[Active],
       CASE WHEN EXISTS (SELECT 1 
                         FROM dbo.cft_PARTIAL_TICKET PT
                         INNER JOIN dbo.cft_CORN_TICKET CT ON CT.TicketID = PT.FullTicketID 
                         WHERE CT.FeedMillID = FeedMillID AND PT.DeliveryDate BETWEEN EffectiveDateFrom AND isnull(EffectiveDateTo,'12/31/2050')
                        ) THEN 1 ELSE 0 END AS HasTickets,
       HC.[CreatedDateTime],
       HC.[CreatedBy],
       HC.[UpdatedDateTime],
       HC.[UpdatedBy]
FROM dbo.cft_GPA_HANDLING_CHARGE HC
WHERE HC.Active = 1 
      AND HC.[Default] = 0 
      AND HC.FeedMillID = @FeedMillID
      AND @Date BETWEEN HC.EffectiveDateFrom AND HC.EffectiveDateTo


END ELSE BEGIN

SELECT HC.[GPAHandlingChargeID],
       HC.[HandlingCharge],
       HC.[EffectiveDateFrom],
       HC.[EffectiveDateTo],
       HC.[FreeDelayedPricingLength],
       HC.[ChargesBeginDate],
       HC.[Default],
       HC.[Active],
       CASE WHEN EXISTS (SELECT 1 
                         FROM dbo.cft_PARTIAL_TICKET PT
                         INNER JOIN dbo.cft_CORN_TICKET CT ON CT.TicketID = PT.FullTicketID 
                         WHERE CT.FeedMillID = FeedMillID AND PT.DeliveryDate BETWEEN EffectiveDateFrom AND isnull(EffectiveDateTo,'12/31/2050')
                        ) THEN 1 ELSE 0 END AS HasTickets,
       HC.[CreatedDateTime],
       HC.[CreatedBy],
       HC.[UpdatedDateTime],
       HC.[UpdatedBy]
FROM dbo.cft_GPA_HANDLING_CHARGE HC
WHERE HC.Active = 1 
      AND HC.[Default] = 1 
      AND HC.FeedMillID = @FeedMillID
      AND @Date BETWEEN HC.EffectiveDateFrom AND isnull(HC.EffectiveDateTo,'12/31/2050')

END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_HANDLING_CHARGE_SELECT_BY_FEED_MILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];


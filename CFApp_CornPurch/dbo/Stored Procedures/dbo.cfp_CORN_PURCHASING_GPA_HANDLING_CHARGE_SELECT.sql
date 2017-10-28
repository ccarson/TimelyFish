
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects all GpaHandlingCharge records
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_HANDLING_CHARGE_SELECT]
AS
BEGIN
SET NOCOUNT ON;

SELECT [GPAHandlingChargeID],
       [FeedMillID],
       [HandlingCharge],
       [EffectiveDateFrom],
       [EffectiveDateTo],
       [FreeDelayedPricingLength],
       [ChargesBeginDate],
       [Default],
       [Active],
       CASE WHEN EXISTS (SELECT 1 
                         FROM dbo.cft_PARTIAL_TICKET PT
                         INNER JOIN dbo.cft_CORN_TICKET CT ON CT.TicketID = PT.FullTicketID 
                         WHERE CT.FeedMillID = FeedMillID AND PT.DeliveryDate BETWEEN EffectiveDateFrom AND isnull(EffectiveDateTo,'12/31/2050')
                        ) THEN 1 ELSE 0 END AS HasTickets,
       [CreatedDateTime],
       [CreatedBy],
       [UpdatedDateTime],
       [UpdatedBy]
FROM dbo.cft_GPA_HANDLING_CHARGE
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_HANDLING_CHARGE_SELECT] TO [db_sp_exec]
    AS [dbo];



-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects GpaDryingCharge record by id
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GPA_DRYING_CHARGE_SELECT_BY_ID]
(
    @GPADryingChargeID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT [GPAMoistureValuationMethodID],
       [FeedMillID],
       [EffectiveDateFrom],
       [EffectiveDateTo],
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
FROM dbo.cft_GPA_DRYING_CHARGE
WHERE GPADryingChargeID = @GPADryingChargeID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_DRYING_CHARGE_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];


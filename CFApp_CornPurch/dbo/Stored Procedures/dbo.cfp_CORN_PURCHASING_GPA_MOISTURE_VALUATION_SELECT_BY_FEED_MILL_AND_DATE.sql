
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 06/20/2008
-- Description:	Selects GpaMoistureValuation record by feed mill id and effective dates
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_GPA_MOISTURE_VALUATION_SELECT_BY_FEED_MILL_AND_DATE
(
    @FeedMillID	char(10),
    @Date	datetime
)
AS
BEGIN
SET NOCOUNT ON;


IF EXISTS (SELECT 1
           FROM dbo.cft_GPA_MOISTURE_VALUATION MV
           WHERE MV.Active = 1 
                 AND MV.[Default] = 0 
                 AND MV.FeedMillID = @FeedMillID
                 AND @Date BETWEEN MV.EffectiveDateFrom AND MV.EffectiveDateTo

          )
BEGIN

SELECT MV.[GPAMoistureValuationID],
       MV.[GPAMoistureValuationMethodID],
       MV.[EffectiveDateFrom],
       MV.[EffectiveDateTo],
       MV.[Default],
       MV.[Active],
       CASE WHEN EXISTS (SELECT 1 
                         FROM dbo.cft_PARTIAL_TICKET PT
                         INNER JOIN dbo.cft_CORN_TICKET CT ON CT.TicketID = PT.FullTicketID 
                         WHERE CT.FeedMillID = FeedMillID AND PT.DeliveryDate BETWEEN EffectiveDateFrom AND isnull(EffectiveDateTo,'12/31/2050')
                        ) THEN 1 ELSE 0 END AS HasTickets,
       MV.[CreatedDateTime],
       MV.[CreatedBy],
       MV.[UpdatedDateTime],
       MV.[UpdatedBy]
FROM dbo.cft_GPA_MOISTURE_VALUATION MV
WHERE MV.Active = 1 
      AND MV.[Default] = 0 
      AND MV.FeedMillID = @FeedMillID
      AND @Date BETWEEN MV.EffectiveDateFrom AND MV.EffectiveDateTo

END ELSE BEGIN

SELECT MV.[GPAMoistureValuationID],
       MV.[GPAMoistureValuationMethodID],
       MV.[EffectiveDateFrom],
       MV.[EffectiveDateTo],
       MV.[Default],
       MV.[Active],
       CASE WHEN EXISTS (SELECT 1 
                         FROM dbo.cft_PARTIAL_TICKET PT
                         INNER JOIN dbo.cft_CORN_TICKET CT ON CT.TicketID = PT.FullTicketID 
                         WHERE CT.FeedMillID = FeedMillID AND PT.DeliveryDate BETWEEN EffectiveDateFrom AND isnull(EffectiveDateTo,'12/31/2050')
                        ) THEN 1 ELSE 0 END AS HasTickets,
       MV.[CreatedDateTime],
       MV.[CreatedBy],
       MV.[UpdatedDateTime],
       MV.[UpdatedBy]
FROM dbo.cft_GPA_MOISTURE_VALUATION MV
WHERE MV.Active = 1 
      AND MV.[Default] = 1 
      AND MV.FeedMillID = @FeedMillID
      AND @Date BETWEEN MV.EffectiveDateFrom AND isnull(MV.EffectiveDateTo,'12/31/2050')

END


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GPA_MOISTURE_VALUATION_SELECT_BY_FEED_MILL_AND_DATE] TO [db_sp_exec]
    AS [dbo];


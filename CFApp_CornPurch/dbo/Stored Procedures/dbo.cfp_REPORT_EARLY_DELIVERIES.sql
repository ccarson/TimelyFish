-- =============================================
-- Author:	Andrey Derco
-- Create date: 10/15/2008
-- Description:	Select data for Early\Late Deliveries Report
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_EARLY_DELIVERIES]
(
  @FeedMillID 		char(10),
  @DaysEarlier		int,
  @DaysLater		int,
  @ContractStatusID	int
  
)

AS
BEGIN
  SET NOCOUNT ON;

  SELECT CM.Description


 AS CommodityName,
         V.RemitName AS CornProducerName,
         FT.DeliveryDate,
         PT.TicketNumber,
         PT.DryBushels,
         C.ContractNumber,
         C.DueDateFrom,
         C.DueDateTo,
         CASE WHEN datediff(day, FT.DeliveryDate, C.DueDateFrom) < 0 THEN NULL ELSE datediff(day, FT.DeliveryDate, C.DueDateFrom) END AS DaysEarly,
         CASE WHEN datediff(day, C.DueDateTo, FT.DeliveryDate) < 0 THEN NULL ELSE datediff(day, C.DueDateTo, FT.DeliveryDate) END AS DaysLate
  FROM dbo.cft_PARTIAL_TICKET PT
    INNER JOIN dbo.cft_CONTRACT C ON C.ContractID = PT.ContractID
    INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendId = ISNULL(PT.DeliveryCornProducerID, PT.CornProducerID)
    INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
    INNER JOIN dbo.cft_COMMODITY CM ON CM.CommodityID = FT.CommodityID
  WHERE C.FeedMillID = @FeedMillID
        AND C.ContractStatusID = @ContractStatusID
        AND ((convert(varchar, FT.DeliveryDate, 101) < C.DueDateFrom AND convert(varchar, FT.DeliveryDate, 101) >= dateadd(day, -1 * ISNULL(@DaysEarlier, 0), C.DueDateFrom))
          OR (convert(varchar, FT.DeliveryDate, 101) > C.DueDateTo AND convert(varchar, FT.DeliveryDate, 101) <= dateadd(day, ISNULL(@DaysLater, 0), C.DueDateTo)))
  ORDER BY 1,2,6

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_EARLY_DELIVERIES] TO [db_sp_exec]
    AS [dbo];


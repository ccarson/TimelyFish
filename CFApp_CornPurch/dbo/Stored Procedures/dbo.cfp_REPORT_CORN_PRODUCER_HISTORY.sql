-- =============================================
-- Author:	Andrey Derco
-- Create date: 10/15/2008
-- Description:	Select data for Corn Producer History Report
-- =============================================

/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2012-01-13  Doran Dahle Changed how the CropYear is calculated.  Changed the +1 to a -1						

===============================================================================
*/
create PROCEDURE [dbo].[cfp_REPORT_CORN_PRODUCER_HISTORY]
(
  @FeedMillID 		char(10),
  @StartDate		datetime,
  @EndDate		datetime
)

AS
BEGIN
  SET NOCOUNT ON;



  SELECT CP.CornProducerID,
         V.RemitName AS CornProducerName,
         CASE WHEN month(FT.DeliveryDate) <=9 THEN year(FT.DeliveryDate) - 1 ELSE year(FT.DeliveryDate) END AS CropYear,
         SUM(PT.DryBushels) AS DryBushels
  FROM dbo.cft_CORN_PRODUCER CP
    INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendId = CP.CornProducerID
    INNER JOIN dbo.cft_PARTIAL_TICKET PT ON isnull(PT.DeliveryCornProducerID, PT.CornProducerID) = CP.CornProducerID
    INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
  WHERE FT.FeedMillID = @FeedMillID AND FT.DeliveryDate BETWEEN @StartDate AND dateadd(second,86399,@EndDate)
  GROUP BY CP.CornProducerID,
           V.RemitName,
           CASE WHEN month(FT.DeliveryDate) <=9 THEN year(FT.DeliveryDate) - 1 ELSE year(FT.DeliveryDate) END                         

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_CORN_PRODUCER_HISTORY] TO [db_sp_exec]
    AS [dbo];




-- =============================================
-- Author:	Andrey Derco
-- Create date: 10/13/2008
-- Description:	Select data for Delivery Detail Report
-- 2012-07-11 sripley  Added (nolock) to tables
-- 2012-07-11 sripley	added additional columns as per SHesse request 
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_DELIVERY_DETAIL]
(
  @FeedMillID 		char(10),
  @CornProducerID	char(15),
  @StartDate 		datetime,
  @EndDate 		datetime,
  @PaymentTypeID	int,
  @ContractTypeID	int,
  @ContractNumber	varchar(100)
)

AS
BEGIN
  SET NOCOUNT ON;

SELECT FM.Name AS FeedMillName,
       V.RemitName AS CornProducerName,
       PT.TicketNumber,
       FT.DeliveryDate,
       CT.Name AS ContractTypeName,
       TPT.Name AS PaymentTypeName,
       C.ContractNumber,
		cast(FT.Moisture as decimal(18,1)) AS Moisture,					-- 20120711 smr
		cast(FT.TestWeight as decimal(18,1)) AS TestWeight,				-- 20120711	smr
		cast(FT.ForeignMaterial as decimal(18,1)) AS ForeignMaterial,	--20120711 smr
       SUM(PT.DryBushels) AS DryBushels,
       SUM(PT.WetBushels) AS WetBushels
FROM dbo.cft_FEED_MILL FM (nolock)
INNER JOIN dbo.cft_CORN_TICKET FT  (nolock) ON FT.FeedMillID = FM.FeedMillID
INNER JOIN dbo.cft_PARTIAL_TICKET PT  (nolock) ON PT.FullTicketID = FT.TicketID
INNER JOIN [$(SolomonApp)].dbo.Vendor V  (nolock) ON V.VendId = ISNULL(PT.DeliveryCornProducerID, PT.CornProducerID)
INNER JOIN dbo.cft_TICKET_PAYMENT_TYPE TPT  (nolock) ON PT.PaymentTypeID = TPT.PaymentTypeID
LEFT OUTER JOIN dbo.cft_CONTRACT C  (nolock) ON C.ContractID = PT.ContractID
LEFT OUTER JOIN dbo.cft_CONTRACT_TYPE CT  (nolock) ON C.ContractTypeID = CT.ContractTypeID
WHERE (RTRIM(@FeedMillID) = '%' OR FM.FeedMillID = @FeedMillID)
      AND convert(varchar,PT.DeliveryDate,101) BETWEEN @StartDate AND @EndDate
      AND (@CornProducerID = '%' OR (ISNULL(PT.DeliveryCornProducerID, PT.CornProducerID) = @CornProducerID))
      AND (@ContractNumber IS NULL OR C.ContractNumber = @ContractNumber)
      AND (@PaymentTypeID = 0 OR PT.PaymentTypeID = @PaymentTypeID)
      AND (@ContractTypeID = 0 OR C.ContractTypeID = @ContractTypeID)
GROUP BY FM.Name,
         V.RemitName,
         PT.TicketNumber,
         FT.DeliveryDate,
         CT.Name,
         TPT.Name,
         C.ContractNumber
         , FT.Moisture, FT.TestWeight, FT.ForeignMaterial				-- 20120711 smr

ORDER BY 4,3
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_DELIVERY_DETAIL] TO [db_sp_exec]
    AS [dbo];


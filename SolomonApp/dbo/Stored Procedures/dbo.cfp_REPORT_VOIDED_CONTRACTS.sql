

-- ===================================================================
-- Author:  Sergey Neskin
-- Create date: 07/26/2008
-- Description: Selects data for Voided Contracts report
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_VOIDED_CONTRACTS]
(
	@FeedMillID varchar(30),
    @StartDate datetime,
	@EndDate datetime
)
AS
BEGIN
SET NOCOUNT ON;

SELECT 
		FM.Name AS FeedMillName,
		@StartDate AS StartDate,
		@EndDate AS EndDate,
		ARPT.CornProducerID AS CornProducerID,
	    V.RemitName AS CornProducerName,
	    C.ContractID AS ContractID,
	    CT.Name AS ContractType,
	    C.Comments AS Notes

FROM dbo.cft_CONTRACT C 
	INNER JOIN dbo.cft_CONTRACT_TYPE CT ON CT.ContractTypeID = C.ContractTypeID
	INNER JOIN dbo.cft_FEED_MILL FM ON FM.FeedMillID = C.FeedMillID	
	INNER JOIN dbo.cft_AR_PARTIAL_TICKET ARPT ON ARPT.ContractID = C.ContractID AND ARPT.RowChangeTypeID = 3 --partial ticket was deleted when the full ticket was voiding
	INNER JOIN dbo.cft_CORN_TICKET FT ON ARPT.FullTicketID = FT.TicketID AND FT.TicketStatusID = 2
	INNER JOIN SolomonApp.dbo.Vendor V ON V.VendId = ARPT.CornProducerID
WHERE ARPT.DeliveryDate BETWEEN @StartDate AND @EndDate AND
	  C.FeedMillID = @FeedMillID 

ORDER BY CornProducerID


END


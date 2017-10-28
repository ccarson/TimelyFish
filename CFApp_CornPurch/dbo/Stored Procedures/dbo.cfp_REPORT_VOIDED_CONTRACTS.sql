

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
		C.CornProducerID AS CornProducerID,
		V.RemitName AS CornProducerName,
		C.ContractID AS ContractID,
		CT.Name AS ContractType,
		C.Comments AS Notes

FROM dbo.cft_CONTRACT C 
	INNER JOIN dbo.cft_CONTRACT_TYPE CT ON CT.ContractTypeID = C.ContractTypeID
	INNER JOIN dbo.cft_FEED_MILL FM ON FM.FeedMillID = C.FeedMillID	
	INNER JOIN (SELECT DISTINCT AR.ContractID 
                    FROM dbo.cft_AR_PARTIAL_TICKET AR
                    INNER JOIN dbo.cft_CORN_TICKET FT ON AR.FullTicketID = FT.TicketID AND FT.TicketStatusID = 2
                    WHERE RowChangeTypeID = 3 AND AR.DeliveryDate BETWEEN @StartDate AND @EndDate) AS ARPT ON ARPT.ContractID = C.ContractID  --partial ticket was deleted when the full ticket was voiding
	
	INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendId = C.CornProducerID
WHERE C.FeedMillID = @FeedMillID 

ORDER BY CornProducerID


END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_VOIDED_CONTRACTS] TO [db_sp_exec]
    AS [dbo];


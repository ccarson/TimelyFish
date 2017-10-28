

-- ===================================================================
-- Author:  Sergey Neskin
-- Create date: 07/26/2008
-- Description: Selects data for Unreturned Contracts report
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_UNRETURNED_CONTRACTS]
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
	V.RemitPhone AS PhoneNumber,
	C.ContractNumber AS ContractNumber,
	CT.Name AS ContractType,
	ISNULL(C.ContractTypeChangeDate, C.DateEstablished) AS DateEstablished,
	dbo.cffn_PLUS_SEVEN_BUSINESS_DAYS(ISNULL(C.ContractTypeChangeDate, C.DateEstablished)) AS ReturnDate,
	CS.Name AS ContractStatus

FROM cft_CONTRACT C
	INNER JOIN dbo.cft_CONTRACT_TYPE CT (NOLOCK) ON CT.ContractTypeID = C.ContractTypeID
	INNER JOIN dbo.cft_FEED_MILL FM (NOLOCK) ON FM.FeedMillID = C.FeedMillID
	INNER JOIN [$(SolomonApp)].dbo.Vendor V (NOLOCK) ON V.VendId = C.CornProducerID
	INNER JOIN dbo.cft_CONTRACT_STATUS CS (nolock) ON CS.ContractStatusID = C.ContractStatusID

WHERE C.Returned != 1 AND
	  C.FeedMillID = @FeedMillID AND
	  --C.UpdatedDateTime BETWEEN @StartDate AND @EndDate
          dbo.cffn_PLUS_SEVEN_BUSINESS_DAYS(ISNULL(C.ContractTypeChangeDate, C.DateEstablished)) BETWEEN ISNULL(@StartDate, '01/01/1900') AND ISNULL(@EndDate, '12/31/2050') AND
	  C.ContractStatusID in (1,2)

ORDER BY CornProducerID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_UNRETURNED_CONTRACTS] TO [db_sp_exec]
    AS [dbo];




-- ===================================================================
-- Author:  Sergey Neskin
-- Create date: 07/26/2008
-- Description: Selects data for Assembly Sheet report
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_ASSEMBLY_SHEET]
(
    @CornProducerID varchar(15),
    @StartDate datetime,
	@EndDate datetime
)
AS
BEGIN
SET NOCOUNT ON;

SELECT  CM.Description AS Commodity,
		FT.DeliveryDate AS DeliveryDate, 
		PT.TicketNumber AS TicketNumber, 
		--FT.Net / 56 AS WetBushels, 
		PT.WetBushels AS WetBushels,
		PT.DryBushels AS DryBushels, 
		cast(FT.Moisture as decimal(18,1)) AS Moisture, 
		cast(FT.TestWeight as decimal(18,1)) AS TestWeight, 
		cast(FT.ForeignMaterial as decimal(18,1)) AS ForeignMaterial, 
		PT.MiscAdj AS MiscAdj, 
		C.ContractNumber AS ContractNumber, 
		CT.Name AS ContractType,
		FT.FeedMillID AS FeedMillID,
		FM.Name AS FeedMillName,
		V.RemitName AS CornProducerName,
		V.RemitAddr1 MailingAddress1,
		V.RemitAddr2 MailingAddress2,
		V.RemitCity MailingCity,
		V.RemitState MailingState,
		V.RemitZip MailingZip
		
FROM cft_PARTIAL_TICKET PT
	INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
	INNER JOIN dbo.cft_FEED_MILL FM ON FM.FeedMillID = FT.FeedMillID
	INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendId = @CornProducerID
	INNER JOIN dbo.cft_COMMODITY CM ON CM.Name = FT.Commodity
	LEFT OUTER JOIN dbo.cft_CONTRACT C ON C.ContractID = PT.ContractID
	LEFT OUTER JOIN dbo.cft_CONTRACT_TYPE CT ON CT.ContractTypeID = C.ContractTypeID
	
WHERE PT.CornProducerID = @CornProducerID AND
	  convert(varchar,FT.DeliveryDate,101) BETWEEN @StartDate AND @EndDate
ORDER BY 2,3
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_ASSEMBLY_SHEET] TO [db_sp_exec]
    AS [dbo];


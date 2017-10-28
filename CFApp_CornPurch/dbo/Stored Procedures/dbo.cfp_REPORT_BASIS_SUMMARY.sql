

-- ===================================================================
-- Author:  Sergey Neskin
-- Create date: 08/29/2008
-- Description: Selects data for Report Basis report
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_BASIS_SUMMARY]
(
	@FeedMillID char(10),
	@StartDate datetime,
	@EndDate datetime
)
AS
BEGIN
SET NOCOUNT ON;

DECLARE @currentYear int
DECLARE @lastYear int

SET @currentYear = DATEPART(yy, @StartDate);
SET @lastYear = DATEPART(yy, @EndDate);

CREATE TABLE #CropYearTable (cropYear VARCHAR(15) PRIMARY KEY, startYear datetime, endYear datetime)

WHILE @currentYear < @lastYear
BEGIN
	INSERT INTO #CropYearTable 
		VALUES (CAST(@currentYear AS varchar(4))+ '-' + CAST(@currentYear+1 AS varchar(4)), 
				CAST((CAST(@currentYear AS varchar(4)) + '/10/01') AS datetime) , 
				CAST((CAST(@currentYear + 1 AS varchar(4)) + '/09/30') AS datetime))
	SET @currentYear = @currentYear + 1;
END


SELECT  CY.CropYear, 
		DATENAME(month, C.DateEstablished) AS DateMonth,
		C.DateEstablished,
		C.Bushels AS ContractedBushels,
		C.Bushels * C.PricedBasis AS ContractedBasis,
		0 AS ReceivedBushels,
		0 AS ReceivedBasis,
		CASE WHEN CT.CRM = 1 THEN 'CRM'
			 WHEN CP.Elevator = 0 THEN 'Producer'
			 WHEN CP.Elevator = 1 THEN 'Elevator'
		END AS RecordType
FROM cft_PARTIAL_TICKET PT 
	INNER JOIN cft_CONTRACT C ON C.ContractID = PT.ContractID
	INNER JOIN cft_CONTRACT_TYPE CT ON CT.ContractTypeID = C.ContractTypeID
	INNER JOIN cft_CORN_PRODUCER CP ON CP.CornProducerID = C.CornProducerID
	INNER JOIN #CropYearTable CY ON C.DateEstablished BETWEEN CY.StartYear AND CY.EndYear

UNION ALL

SELECT  CY.CropYear,
		DATENAME(month, PT.DeliveryDate) AS DateMonth,
		PT.DeliveryDate, 
		0 AS ContractedBushels,
		0 AS ContractedBasis,
		PT.DryBushels AS ReceivedBushels,
		CASE WHEN PT.PaymentTypeID = 2 THEN C.PricedBasis
			 WHEN PT.QuoteID IS NOT NULL THEN Q.Basis
		END AS ReceivedBasis,
		CASE WHEN CP.Elevator = 0 THEN 'Producer'
			 WHEN CP.Elevator = 1 THEN 'Elevator'
		END AS RecordType

FROM cft_PARTIAL_TICKET PT 
	INNER JOIN cft_CORN_PRODUCER CP ON CP.CornProducerID = PT.CornProducerID
	INNER JOIN #CropYearTable CY ON PT.DeliveryDate BETWEEN CY.StartYear AND CY.EndYear
	LEFT OUTER JOIN cft_CONTRACT C ON C.ContractID = PT.ContractID
	LEFT OUTER JOIN cft_QUOTE Q ON Q.QuoteID = PT.QuoteID
WHERE PT.PaymentTypeID != 3

DROP TABLE #CropYearTable


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_BASIS_SUMMARY] TO [db_sp_exec]
    AS [dbo];


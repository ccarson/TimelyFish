-- =============================================
-- Author:	Andrey Derco
-- Create date: 10/15/2008
-- Description:	Select data for Corn Producer History Report
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_OFFER_CONTRACTS]
(
  @FeedMillID 		char(10),
  @StartDate		datetime,
  @EndDate		datetime
)

AS
BEGIN
  SET NOCOUNT ON;

  SELECT V.RemitName AS CornProducerName,
         P.PhoneNbr,
         C.ContractID,
         CT.Name AS ContractTypeName,
         C.SettlementDate,
         C.Offer,
         C.Bushels,
         C.FuturesYear,
         FIN.Name AS FuturesMonth,
         dbo.cffn_CORN_PURCHASING_GET_DAILY_PRICE_BY_FEED_MILL_AND_DATE(@FeedMillID, C.SettlementDate, C.FuturesYear, NULL, C.FuturesMonth) AS Price,
         C.DueDateFrom,
         C.DueDateTo
  FROM dbo.cft_CONTRACT C
    INNER JOIN dbo.cft_CONTRACT_TYPE CT ON C.ContractTypeID = CT.ContractTypeID
    INNER JOIN dbo.cft_CORN_PRODUCER CP ON C.CornProducerID = CP.CornProducerID
    INNER JOIN dbo.cft_Vendor V ON V.VendId = CP.CornProducerID
    INNER JOIN dbo.cft_FINANCIAL_MONTH FIN ON Fin.FinancialMonthID = C.FuturesMonth
    LEFT OUTER JOIN [$(CFApp_Contact)].dbo.cft_CONTACT_PHONE CPH ON CP.ContactID = CPH.ContactID AND CPH.PhoneTypeID = 1
    LEFT OUTER JOIN [$(CFApp_Contact)].dbo.cft_PHONE P ON P.PhoneID = CPH.PhoneID

  WHERE convert(varchar, C.SettlementDate, 101) BETWEEN @StartDate AND @EndDate AND convert(varchar, C.SettlementDate, 101) <= dateadd(day,-1,convert(varchar, getdate(), 101))
          AND C.FeedMillID = @FeedMillID
          AND C.ContractStatusID = 1
          AND C.Offer IS NOT NULL
  ORDER BY C.CornProducerID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_OFFER_CONTRACTS] TO [db_sp_exec]
    AS [dbo];


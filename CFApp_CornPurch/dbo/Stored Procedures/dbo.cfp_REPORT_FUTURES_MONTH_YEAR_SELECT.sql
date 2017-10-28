-- =============================================
-- Author:	Andrey Derco
-- Create date: 12/08/2008
-- Description:	Returns all distinct futures month\year pairs from contracts
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_FUTURES_MONTH_YEAR_SELECT]
(
   @FeedMillID  char(10)
)
AS
BEGIN
	SET NOCOUNT ON;

SELECT DISTINCT
  cast(C.FuturesYear as varchar) + cast(C.FuturesMonth as varchar) as FuturesID,
  FinM.Name + '''' + cast(C.FuturesYear as varchar) AS FuturesName
FROM dbo.cft_CONTRACT C  
INNER JOIN dbo.cft_FINANCIAL_MONTH FinM ON C.FuturesMonth = FinM.FinancialMonthID
WHERE C.FeedMillID = @FeedMillID

UNION SELECT 0,'--All--'


ORDER BY FuturesID



END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_FUTURES_MONTH_YEAR_SELECT] TO [db_sp_exec]
    AS [dbo];


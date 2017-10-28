-- =============================================
-- Author:	Andrey Derco
-- Create date: 12/08/2008
-- Description:	Returns all distinct basis month\year pair from contracts
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_BASIS_MONTH_YEAR_SELECT]
(
   @FeedMillID  char(10)
)
AS
BEGIN
	SET NOCOUNT ON;

SELECT DISTINCT
  cast(C.BasisYear as varchar) + cast(C.BasisMonth as varchar) as BasisID,
  FinM.Name + '''' + cast(C.BasisYear as varchar) AS BasisName
FROM dbo.cft_CONTRACT C  
INNER JOIN dbo.cft_FINANCIAL_MONTH FinM ON C.BasisMonth = FinM.FinancialMonthID
WHERE C.FeedMillID = @FeedMillID

UNION SELECT 0, '--All--'


ORDER BY BasisID



END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_BASIS_MONTH_YEAR_SELECT] TO [db_sp_exec]
    AS [dbo];


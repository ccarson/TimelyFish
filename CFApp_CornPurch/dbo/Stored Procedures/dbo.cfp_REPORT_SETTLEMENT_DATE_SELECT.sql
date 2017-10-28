-- =============================================
-- Author:	Andrey Derco
-- Create date: 12/08/2008
-- Description:	Returns all distinct settlement dates from Contracts
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SETTLEMENT_DATE_SELECT]
(
   @FeedMillID  char(10)
)
AS
BEGIN
	SET NOCOUNT ON;


  SELECT DISTINCT
         SettlementDate as SortBy, 
         convert(varchar,SettlementDate,101) as SettlementDate
  FROM dbo.cft_CONTRACT
  WHERE FeedMillID = @FeedMillID AND SettlementDate IS NOT NULL


  UNION SELECT 0,'--All--'


  ORDER BY SortBy

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SETTLEMENT_DATE_SELECT] TO [db_sp_exec]
    AS [dbo];


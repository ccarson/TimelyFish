-- =============================================
-- Author:	Andrey Derco
-- Create date: 10/20/2008
-- Description:	Returns all Contract statuses
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_CONTRACT_STATUS_SELECT]
(
   @IncludeAll	bit
)
AS
BEGIN
	SET NOCOUNT ON;

IF @IncludeAll = 1 BEGIN

  SELECT 0 AS ContractStatusID,
         '--All--' AS ContractStatusName
       
  UNION ALL 

  SELECT ContractStatusID,
         Name AS ContractStatusName
  FROM dbo.cft_CONTRACT_STATUS
  ORDER BY 1

END ELSE BEGIN

  SELECT cast(ContractStatusID as int) as ContractStatusID,
         Name AS ContractStatusName
  FROM dbo.cft_CONTRACT_STATUS
  ORDER BY 1

END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_CONTRACT_STATUS_SELECT] TO [db_sp_exec]
    AS [dbo];


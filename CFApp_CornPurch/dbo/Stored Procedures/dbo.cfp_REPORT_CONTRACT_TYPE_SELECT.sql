-- =============================================
-- Author:	Andrey Derco
-- Create date: 10/13/2008
-- Description:	Returns all contract types
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_CONTRACT_TYPE_SELECT]
(
   @IncludeAll	bit
)
AS
BEGIN
	SET NOCOUNT ON;

IF @IncludeAll = 1 BEGIN

  SELECT 0 AS ContractTypeID,
         '--All--' AS ContractTypeName
       
  UNION ALL 

  SELECT ContractTypeID,
         Name
  FROM dbo.cft_CONTRACT_TYPE

  ORDER BY 2

END ELSE BEGIN

  SELECT ContractTypeID,
         Name AS ContractTypeName
  FROM dbo.cft_CONTRACT_TYPE
  ORDER BY 2

END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_CONTRACT_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];


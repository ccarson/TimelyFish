-- =============================================
-- Author:	Andrey Derco
-- Create date: 10/13/2008
-- Description:	Returns all contract types for feed mill
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_CONTRACT_TYPE_SELECT_BY_FEED_MILL]
(
   @FeedMillID	char(10)
)
AS
BEGIN
	SET NOCOUNT ON;


  SELECT CT.ContractTypeID,
         CT.Name AS ContractTypeName
  FROM dbo.cft_CONTRACT_TYPE CT
  INNER JOIN dbo.cft_CONTRACT_TYPE_FEED_MILL CTFM ON CT.ContractTypeID = CTFM.ContractTypeID
  WHERE CTFM.FeedMillID = @FeedMillID

  UNION SELECT 0, '--All--'

  ORDER BY 2

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_CONTRACT_TYPE_SELECT_BY_FEED_MILL] TO [db_sp_exec]
    AS [dbo];


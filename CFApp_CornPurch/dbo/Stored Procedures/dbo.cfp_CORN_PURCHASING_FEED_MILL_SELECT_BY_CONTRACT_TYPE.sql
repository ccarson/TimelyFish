
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 07/11/2008
-- Description: Selects all FeedMill IDs for Contract type
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_FEED_MILL_SELECT_BY_CONTRACT_TYPE]
(
    @ContractTypeID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT FeedMIllID
FROM  dbo.cft_CONTRACT_TYPE_FEED_MILL
WHERE ContractTypeID = @ContractTypeID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_FEED_MILL_SELECT_BY_CONTRACT_TYPE] TO [db_sp_exec]
    AS [dbo];


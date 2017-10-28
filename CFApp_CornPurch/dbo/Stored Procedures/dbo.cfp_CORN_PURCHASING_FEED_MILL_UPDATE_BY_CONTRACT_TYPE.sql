
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 07/11/2008
-- Description: Updates all FeedMill IDs for Contract type
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_FEED_MILL_UPDATE_BY_CONTRACT_TYPE]
(
    @ContractTypeID	int,
    @FeedMIllIDs	varchar(4000),
    @CreatedBy		varchar(50)
)
AS
BEGIN
SET NOCOUNT ON;

BEGIN TRAN

DELETE dbo.cft_CONTRACT_TYPE_FEED_MILL
WHERE ContractTypeID = @ContractTypeID

INSERT dbo.cft_CONTRACT_TYPE_FEED_MILL
(
   ContractTypeID,
   FeedMillID,
   CreatedBy
)
SELECT @ContractTypeID,
       Value,
       @CreatedBy
FROM dbo.cffn_SPLIT_STRING(@FeedMillIDs,',')

COMMIT TRAN


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_FEED_MILL_UPDATE_BY_CONTRACT_TYPE] TO [db_sp_exec]
    AS [dbo];


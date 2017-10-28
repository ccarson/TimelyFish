
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 07/11/2008
-- Description: Updates all FeedMill IDs for Marketer
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_FEED_MILL_UPDATE_BY_MARKETER]
(
    @MarketerID	int,
    @FeedMIllIDs	varchar(4000),
    @CreatedBy		varchar(50)
)
AS
BEGIN
SET NOCOUNT ON;

BEGIN TRAN

DELETE dbo.cft_MARKETER_FEED_MILL
WHERE MarketerID = @MarketerID

INSERT dbo.cft_MARKETER_FEED_MILL
(
   MarketerID,
   FeedMillID,
   CreatedBy
)
SELECT @MarketerID,
       Value,
       @CreatedBy
FROM dbo.cffn_SPLIT_STRING(@FeedMillIDs,',')

COMMIT TRAN


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_FEED_MILL_UPDATE_BY_MARKETER] TO [db_sp_exec]
    AS [dbo];


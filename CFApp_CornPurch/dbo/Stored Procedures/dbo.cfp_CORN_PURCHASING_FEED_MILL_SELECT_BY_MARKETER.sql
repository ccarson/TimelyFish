
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 07/11/2008
-- Description: Selects all FeedMill IDs for Marketer
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_FEED_MILL_SELECT_BY_MARKETER]
(
    @MarketerID	int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT FeedMIllID
FROM  dbo.cft_MARKETER_FEED_MILL
WHERE MarketerID = @MarketerID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_FEED_MILL_SELECT_BY_MARKETER] TO [db_sp_exec]
    AS [dbo];


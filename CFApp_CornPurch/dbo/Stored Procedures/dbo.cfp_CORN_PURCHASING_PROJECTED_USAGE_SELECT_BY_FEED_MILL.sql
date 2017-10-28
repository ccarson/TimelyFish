
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 11/18/2008
-- Description:	Selects Projected Usage records by feed mill
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_PROJECTED_USAGE_SELECT_BY_FEED_MILL
(
  @FeedMillID	char(10)
)
AS
BEGIN
SET NOCOUNT ON;

SELECT ProjectedUsageID,
       Year,
       Month,
       ProjectedUsage
FROM dbo.cft_PROJECTED_USAGE
WHERE FeedMillID = @FeedMillID
ORDER BY Year DESC, Month DESC
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_PROJECTED_USAGE_SELECT_BY_FEED_MILL] TO [db_sp_exec]
    AS [dbo];


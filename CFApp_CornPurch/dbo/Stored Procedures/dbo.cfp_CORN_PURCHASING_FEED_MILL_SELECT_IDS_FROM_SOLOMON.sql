
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 06/30/2008
-- Description: Selects all FeedMill IDs from Solomon
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_FEED_MILL_SELECT_IDS_FROM_SOLOMON]
AS
BEGIN
SET NOCOUNT ON;

SELECT S.SiteID AS FeedMillID
FROM [$(SolomonApp)].dbo.Site S
LEFT OUTER JOIN dbo.cft_FEED_MILL FM ON S.SiteID = FM.FeedMillID  
WHERE FM.FeedMillID IS NULL
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_FEED_MILL_SELECT_IDS_FROM_SOLOMON] TO [db_sp_exec]
    AS [dbo];


-- =============================================
-- Author:		Matt Dawson
-- Create date: 11/11/2008
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[cfp_FEED_MILL_SITE_DIRECTIONS]
	@FeedMillID CHAR(10)
AS
BEGIN

SELECT
	sd.SiteDirectionsID
,	sd.ContactID
,	c.ContactName
,	sd.FeedMillID
,	sd.RoadRestrictions
,	sd.Active
,	sd.Directions
,	sd.CreatedBy
,	sd.CreatedDateTime
,	sd.UpdatedBy
,	sd.UpdatedDateTime
FROM	dbo.cft_FEED_MILL_SITE_DIRECTIONS sd (NOLOCK)
INNER JOIN [$(CentralData)].dbo.Contact c (NOLOCK)
	ON c.ContactID = sd.ContactID
WHERE	RTRIM(sd.FeedMillID) = @FeedMillID
ORDER BY c.ContactName
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FEED_MILL_SITE_DIRECTIONS] TO [db_sp_exec]
    AS [dbo];


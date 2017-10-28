
-- ===================================================================
-- Author:	Matt Dawson
-- Create date: 11/13/2008
-- Description:	Inserts the Site Directions record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_FEED_MILL_SITE_DIRECTIONS_INSERT]
(
	@ContactID int
,	@FeedMillID char(10)
,	@RoadRestrictions bit
,	@Active bit
,	@Directions varchar(4000)
,	@CreatedBy varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT INTO cft_FEED_MILL_SITE_DIRECTIONS
		(ContactID
		,FeedMillID
		,RoadRestrictions
		,Active
		,Directions
		,CreatedBy
		,CreatedDateTime)
	VALUES
		(@ContactID
		,@FeedMillID
		,@RoadRestrictions
		,@Active
		,@Directions
		,@CreatedBy
		,GetDate())
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FEED_MILL_SITE_DIRECTIONS_INSERT] TO [db_sp_exec]
    AS [dbo];


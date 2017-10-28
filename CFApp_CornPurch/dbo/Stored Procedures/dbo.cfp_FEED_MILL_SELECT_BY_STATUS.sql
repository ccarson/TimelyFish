-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 03/16/2008
-- Description:	Returns all Feed Mills by Status 
-- =============================================
CREATE PROCEDURE [dbo].[cfp_FEED_MILL_SELECT_BY_STATUS]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT FeedMillID
		, Name
FROM dbo.cft_FEED_MILL
Order By Name
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FEED_MILL_SELECT_BY_STATUS] TO [db_sp_exec]
    AS [dbo];


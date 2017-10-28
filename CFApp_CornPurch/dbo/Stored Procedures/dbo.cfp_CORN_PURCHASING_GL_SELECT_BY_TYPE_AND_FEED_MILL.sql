-- ======================================================================
-- Author:		Brian Cesafsky
-- Create date: 08/25/2008
-- Description:	Returns a GL record by Type and FeedMill
-- ======================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_GL_SELECT_BY_TYPE_AND_FEED_MILL]
(
	@GlTypeID				int
	,@FeedMillID			char(10)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT GlID
			,GlTypeID
			,FeedMillID
			,ExpenseAccount
			,SubAccount
	FROM dbo.cft_GL
	WHERE GlTypeID = @GlTypeID
		AND FeedMillID = @FeedMillID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_GL_SELECT_BY_TYPE_AND_FEED_MILL] TO [db_sp_exec]
    AS [dbo];


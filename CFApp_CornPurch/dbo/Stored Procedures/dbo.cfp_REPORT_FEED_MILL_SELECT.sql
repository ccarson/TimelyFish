-- =============================================
-- Author:		Matt Dawson
-- Create date: 08/14/2008
-- Description:	Returns all Feed Mills
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_FEED_MILL_SELECT]
(
  @IncludeAll	bit 	= 1
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


IF @IncludeAll = 1 BEGIN

  SELECT '%' 'FeedMillID', '--All--' 'Name'

  UNION ALL 

  SELECT FeedMillID, Name 
  FROM dbo.cft_FEED_MILL WITH (NOLOCK)
  ORDER BY Name

END ELSE BEGIN

  SELECT FeedMillID, 
         Name 
  FROM dbo.cft_FEED_MILL WITH (NOLOCK)
  ORDER BY Name

END 

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_FEED_MILL_SELECT] TO [db_sp_exec]
    AS [dbo];


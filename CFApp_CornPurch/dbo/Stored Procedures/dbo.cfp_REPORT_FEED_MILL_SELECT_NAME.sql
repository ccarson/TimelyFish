-- =============================================
-- Author:	Andrey Derco
-- Create date: 10/08/2008
-- Description:	Returns all Feed Mills
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_FEED_MILL_SELECT_NAME]
(
  @FeedMillID	char(10)
)
AS
BEGIN
	SET NOCOUNT ON;

IF ISNULL(@FeedMillID, '%') = '%' BEGIN

  SELECT 'All Feed Mills' AS Name

END ELSE BEGIN

  SELECT Name 
  FROM dbo.cft_FEED_MILL WITH (NOLOCK)
  WHERE @FeedMillID = FeedMillID

END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_FEED_MILL_SELECT_NAME] TO [db_sp_exec]
    AS [dbo];


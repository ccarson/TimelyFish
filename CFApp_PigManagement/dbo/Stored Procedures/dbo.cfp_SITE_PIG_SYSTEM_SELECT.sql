-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 07/01/2009
-- Description:	Returns all Site Pig Systems
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SITE_PIG_SYSTEM_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT SitePigSystemID
	  ,SitePigSystemDescription
FROM dbo.cft_SITE_PIG_SYSTEM (NOLOCK)
Order By SitePigSystemDescription
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_PIG_SYSTEM_SELECT] TO [db_sp_exec]
    AS [dbo];


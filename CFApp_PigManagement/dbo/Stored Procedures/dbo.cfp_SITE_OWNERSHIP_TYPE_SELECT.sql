-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 07/01/2009
-- Description:	Returns all Site Ownership Types
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SITE_OWNERSHIP_TYPE_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT SiteOwnershipTypeID
	  ,SiteOwnershipTypeDescription
FROM dbo.cft_SITE_OWNERSHIP_TYPE (NOLOCK)
Order By SiteOwnershipTypeDescription
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_OWNERSHIP_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];



-- =========================================================
-- Author:	Brian Cesafsky
-- Create date: 07/08/2009
-- Description:	selects Pork Board Audit records for a site
-- =========================================================
CREATE PROCEDURE [dbo].[cfp_SITE_PORK_BOARD_AUDIT_SELECT]
(
	@SiteID int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT PorkBoardAuditID
		,SiteID
		,PorkBoardAuditor
		,PorkBoardAuditDate
		,PorkBoardAuditPass
	FROM dbo.cft_SITE_PORK_BOARD_AUDIT (NOLOCK)
	WHERE SiteID = @SiteID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_PORK_BOARD_AUDIT_SELECT] TO [db_sp_exec]
    AS [dbo];


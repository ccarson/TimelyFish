-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 07/08/2009
-- Description:	Creates a Site Pork Board Audit record
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_SITE_PORK_BOARD_AUDIT_INSERT]
(	
	@SiteID [int] 
	,@PorkBoardAuditor [varchar](50) 
	,@PorkBoardAuditDate[datetime]
	,@PorkBoardAuditPass [bit]
	,@CreatedBy [varchar](50) 
)
AS
BEGIN
	INSERT INTO dbo.cft_SITE_PORK_BOARD_AUDIT
	(
		SiteID
		,PorkBoardAuditor 
		,PorkBoardAuditDate
		,PorkBoardAuditPass
		,CreatedBy
	)
	VALUES 
	(
		@SiteID
		,@PorkBoardAuditor
		,@PorkBoardAuditDate
		,@PorkBoardAuditPass
		,@CreatedBy
	)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_PORK_BOARD_AUDIT_INSERT] TO [db_sp_exec]
    AS [dbo];


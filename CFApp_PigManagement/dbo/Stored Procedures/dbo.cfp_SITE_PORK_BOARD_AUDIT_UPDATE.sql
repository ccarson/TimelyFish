-- ================================================================
-- Author:		Brian Cesafsky
-- Create date: 07/08/2009
-- Description:	Updates the a Site Pork Board Audit record
-- ================================================================
CREATE PROCEDURE [dbo].[cfp_SITE_PORK_BOARD_AUDIT_UPDATE]
(
	@PorkBoardAuditID [int] 
	,@PorkBoardAuditor [varchar](50) 
	,@PorkBoardAuditDate [datetime]
	,@PorkBoardAuditPass [bit]
	,@UpdatedBy [varchar](50) 
)
AS
BEGIN
	UPDATE dbo.cft_SITE_PORK_BOARD_AUDIT
	SET PorkBoardAuditor = @PorkBoardAuditor
		,PorkBoardAuditDate = @PorkBoardAuditDate
		,PorkBoardAuditPass = @PorkBoardAuditPass
		,UpdatedDateTime = getdate()
		,UpdatedBy = @UpdatedBy
	WHERE [PorkBoardAuditID] = @PorkBoardAuditID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_PORK_BOARD_AUDIT_UPDATE] TO [db_sp_exec]
    AS [dbo];


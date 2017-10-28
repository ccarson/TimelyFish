-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 07/07/2009
-- Description:	Creates a Site NAIS record
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_SITE_NAIS_INSERT]
(	
	@SiteID [int] 
	,@NaisDisplayID [varchar](7) 
	,@OriginalIssueDateTime[datetime]
	,@Active [bit]
	,@CreatedBy [varchar](50) 
)
AS
BEGIN
	INSERT INTO dbo.cft_SITE_NAIS
	(
		SiteID
		,NaisDisplayID
		,OriginalIssueDateTime
		,Active
		,CreatedBy
	)
	VALUES 
	(
		@SiteID
		,@NaisDisplayID
		,@OriginalIssueDateTime
		,@Active
		,@CreatedBy
	)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_NAIS_INSERT] TO [db_sp_exec]
    AS [dbo];


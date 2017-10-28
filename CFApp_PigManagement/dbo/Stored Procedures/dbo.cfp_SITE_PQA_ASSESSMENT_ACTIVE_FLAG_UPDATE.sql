-- ================================================================
-- Author:		Brian Cesafsky
-- Create date: 04/27/2009
-- Description:	Updates the Active column for the Site PQA+ record
-- ===================================++++=========================
CREATE PROCEDURE [dbo].[cfp_SITE_PQA_ASSESSMENT_ACTIVE_FLAG_UPDATE]
(
	@PqaAssessmentID [int] 
	,@Active [bit]
	,@UpdatedBy [varchar](50) 
)
AS
BEGIN
	UPDATE dbo.cft_SITE_PQA_ASSESSMENT
	SET Active = @Active
		,UpdatedDateTime = getdate()
		,UpdatedBy = @UpdatedBy
	WHERE [PqaAssessmentID] = @PqaAssessmentID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_PQA_ASSESSMENT_ACTIVE_FLAG_UPDATE] TO [db_sp_exec]
    AS [dbo];


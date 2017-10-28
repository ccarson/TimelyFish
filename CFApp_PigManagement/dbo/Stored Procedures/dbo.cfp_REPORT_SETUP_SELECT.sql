-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 01/15/2010
-- Description:	Returns all report names
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SETUP_SELECT]
(	
	@Active		bit
)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT ReportID
		  ,ReportName
		  ,ReportDescription
	FROM dbo.cft_REPORT_NAME (NOLOCK)
	WHERE @Active = Active
	ORDER BY ReportName
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SETUP_SELECT] TO [db_sp_exec]
    AS [dbo];


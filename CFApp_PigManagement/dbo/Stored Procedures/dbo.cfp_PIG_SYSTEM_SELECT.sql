-- =============================================================================
-- Author:		Brian Cesafsky
-- Create date: 05/10/2010
-- Description:	Selects Pig Systems
-- =============================================================================
CREATE PROCEDURE [dbo].[cfp_PIG_SYSTEM_SELECT]
(
	@Active		bit
)
AS
BEGIN
	SELECT PigSystemID
		 , Name
		 , Description
		 , Active
		 , HasFlow
	FROM dbo.cft_PIG_SYSTEM (NOLOCK)
	WHERE Active = @Active
	ORDER BY Name ASC
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_SYSTEM_SELECT] TO [db_sp_exec]
    AS [dbo];


-- ================================================================
-- Author:		Brian Cesafsky
-- Create date: 04/27/2009
-- Description:	Updates the Active column for the Site NAIS record
-- ===================================++++=========================
CREATE PROCEDURE [dbo].[cfp_SITE_NAIS_ACTIVE_FLAG_UPDATE]
(
	@NaisID [int] 
	,@Active [bit]
	,@UpdatedBy [varchar](50) 
)
AS
BEGIN
	UPDATE dbo.cft_SITE_NAIS
	SET Active = @Active
		,UpdatedDateTime = getdate()
		,UpdatedBy = @UpdatedBy
	WHERE [NaisID] = @NaisID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_NAIS_ACTIVE_FLAG_UPDATE] TO [db_sp_exec]
    AS [dbo];


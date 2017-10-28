-- =========================================================
-- Author:		Brian Cesafsky
-- Create date: 03/19/2009
-- Description:	Returns Packer Optimizer bypass values
-- =========================================================
CREATE PROCEDURE [dbo].[cfp_PACKER_BYPASS_SELECT_BY_CONTACT_ID]
(
	@ContactID		int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT BypassID
	    ,ContactID
	    ,PigProdPodID
	    ,FeedRation
FROM dbo.cft_PACKER_BYPASS (NOLOCK)
WHERE ContactID = @ContactID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_BYPASS_SELECT_BY_CONTACT_ID] TO [db_sp_exec]
    AS [dbo];


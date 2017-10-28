-- =========================================================
-- Author:		Brian Cesafsky
-- Create date: 01/10/2011
-- Description:	Returns Feed Rations
-- =========================================================
CREATE PROCEDURE [dbo].[cfp_PACKER_BYPASS_SELECT_FEED_RATION]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT InvtID
	      ,Descr
	FROM [$(SolomonApp)].dbo.Inventory (NOLOCK)
	WHERE ClassID='RATION'
	ORDER BY InvtID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_BYPASS_SELECT_FEED_RATION] TO [db_sp_exec]
    AS [dbo];


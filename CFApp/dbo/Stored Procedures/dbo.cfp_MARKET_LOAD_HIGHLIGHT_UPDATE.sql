-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 01/07/2008
-- Description:	Updates a record in the cftPM table
-- =============================================
CREATE PROCEDURE [dbo].[cfp_MARKET_LOAD_HIGHLIGHT_UPDATE]
(
	@Highlight			int
	, @MarketLoadID		int
)
AS
BEGIN

UPDATE [$(SolomonApp)].dbo.cftPM
   SET Highlight = @Highlight
      
where
	id = @MarketLoadID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_LOAD_HIGHLIGHT_UPDATE] TO [db_sp_exec]
    AS [dbo];


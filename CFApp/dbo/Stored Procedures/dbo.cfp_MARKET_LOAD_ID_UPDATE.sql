-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 01/07/2008
-- Description:	Updates a record in the cftPM table
-- =============================================
CREATE PROCEDURE [dbo].[cfp_MARKET_LOAD_ID_UPDATE]
(
	@PMLoadID			int
	, @PMID				int
)
AS
BEGIN

UPDATE [$(SolomonApp)].dbo.cftPM
   SET PMLoadID = @PMLoadID
      
where
	PMID = @PMID
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_LOAD_ID_UPDATE] TO [db_sp_exec]
    AS [dbo];


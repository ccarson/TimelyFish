-- =============================================
-- Author:		Dave Killion
-- Create date: 11/28/2007
-- Description:	Deletes a market load from cftpm
-- =============================================
CREATE PROCEDURE dbo.cfp_MARKET_LOAD_DELETE

	@PigMovementID char(10)
AS

DELETE	
	[$(SolomonApp)].dbo.cftPM
where
	PMID = @PigMovementID

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_LOAD_DELETE] TO [db_sp_exec]
    AS [dbo];


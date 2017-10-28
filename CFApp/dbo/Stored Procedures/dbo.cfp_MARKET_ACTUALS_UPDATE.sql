-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 01/03/2008
-- Description:	Updates the actual qty and weight in the cftPM table
--              Based on a LoadID
-- =============================================
CREATE PROCEDURE [dbo].[cfp_MARKET_ACTUALS_UPDATE]
(
	-- Add the parameters for the stored procedure here
	@PigMovementLoadId char(10)
	, @ActualQuantity int
	, @ActualWeight int
)
AS
BEGIN

UPDATE [$(SolomonApp)].dbo.cftPM
   SET 
	  ActualQty = @ActualQuantity
      ,ActualWgt = @ActualWeight
where
	PMID = @PigMovementLoadId
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_ACTUALS_UPDATE] TO [db_sp_exec]
    AS [dbo];


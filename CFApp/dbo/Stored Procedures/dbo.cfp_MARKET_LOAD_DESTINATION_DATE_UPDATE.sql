-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 01/19/2008
-- Description:	Updates a record in the cftPM table
-- =============================================
CREATE PROCEDURE [dbo].[cfp_MARKET_LOAD_DESTINATION_DATE_UPDATE]
	@DestinationContactID char(10)
	, @LastUpdatedDateTime smalldatetime
	, @LastUpdatedProgram char(8)
	, @LastUpdatedUser char(10)
	, @MarketLoadID int
	, @MovementDate smalldatetime
AS
BEGIN

UPDATE [$(SolomonApp)].dbo.cftPM
   SET
      DestContactID = @DestinationContactID
      ,Lupd_DateTime = @LastUpdatedDateTime
      ,Lupd_Prog = @LastUpdatedProgram
      ,Lupd_User = @LastUpdatedUser
      ,MovementDate = @MovementDate
where
	PMLoadID = @MarketLoadID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_LOAD_DESTINATION_DATE_UPDATE] TO [db_sp_exec]
    AS [dbo];


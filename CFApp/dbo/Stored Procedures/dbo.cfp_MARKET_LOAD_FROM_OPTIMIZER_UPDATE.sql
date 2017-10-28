-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 01/19/2008
-- Description:	Updates a record in the cftPM table
-- =============================================
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2011-07-26  Doran Dahle Added Esitmated Wgt to the update
						

===============================================================================
*/
CREATE PROCEDURE [dbo].[cfp_MARKET_LOAD_FROM_OPTIMIZER_UPDATE]
	@DestinationContactID char(10)
	, @LastUpdatedDateTime smalldatetime
	, @LastUpdatedProgram char(8)
	, @LastUpdatedUser char(10)
	, @MarketLoadID int
	, @MovementDate smalldatetime
	, @OrdNbr char(10)
	, @EstimatedWgt char(7)
AS
BEGIN

UPDATE [$(SolomonApp)].dbo.cftPM
   SET
      DestContactID = @DestinationContactID
      ,Lupd_DateTime = @LastUpdatedDateTime
      ,Lupd_Prog = @LastUpdatedProgram
      ,Lupd_User = @LastUpdatedUser
      ,MovementDate = @MovementDate
      ,OrdNbr = @OrdNbr
      ,EstimatedWgt = @EstimatedWgt
where
	PMLoadID = @MarketLoadID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_LOAD_FROM_OPTIMIZER_UPDATE] TO [db_sp_exec]
    AS [dbo];


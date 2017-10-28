-- ====================================================
-- Author:		<Brian Cesafsky>
-- Create date: <12/17/2007>
-- Description:	<Inserts a Market Optimzer Log record>
-- ====================================================
CREATE PROCEDURE [dbo].[cfp_MARKET_OPTIMIZER_LOG_INSERT]
(
	@LogMessage					    varchar(255)
)	
AS
BEGIN
	INSERT INTO dbo.cft_MARKET_OPTIMIZER_LOG
	(
		LogMessage
	)
	VALUES 
	(	
		@LogMessage
	)
END





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_OPTIMIZER_LOG_INSERT] TO [db_sp_exec]
    AS [dbo];


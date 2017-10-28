-- ========================================================
-- Author:		Brian Cesafsky
-- Create date: 12/26/2007
-- Description:	Deletes all records from the table
-- ========================================================
CREATE PROCEDURE [dbo].[cfp_MARKET_OPTIMIZER_LOG_TRUNCATE]
AS
BEGIN

DELETE from dbo.cft_MARKET_OPTIMIZER_LOG
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_OPTIMIZER_LOG_TRUNCATE] TO [db_sp_exec]
    AS [dbo];


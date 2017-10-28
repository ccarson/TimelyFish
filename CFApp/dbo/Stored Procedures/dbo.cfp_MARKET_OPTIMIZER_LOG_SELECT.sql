-- ========================================================
-- Author:		Brian Cesafsky
-- Create date: 11/11/2007
-- Description:	Selects all records
-- ========================================================
CREATE PROCEDURE [dbo].[cfp_MARKET_OPTIMIZER_LOG_SELECT]
AS
BEGIN
	declare @rows int
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT @rows = count(*)
	FROM dbo.cft_MARKET_OPTIMIZER_LOG (NOLOCK)
	IF (@rows > 0)
		  SELECT LogMessage FROM dbo.cft_MARKET_OPTIMIZER_LOG (NOLOCK)
	ELSE
		  SELECT 'Did Not Run' 'LogMessage'
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_OPTIMIZER_LOG_SELECT] TO [db_sp_exec]
    AS [dbo];


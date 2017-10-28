-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 02/16/2009
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[cfp_PRE_MARKET_BY_PIG_GROUP_ID_SELECT]
	@PigGroupID CHAR(10)
AS
BEGIN
	Select PigGroupID, CalcCurWgt
	From [$(SolomonApp)].dbo.cftPigPreMkt
	Where PigGroupID = @PigGroupID 
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PRE_MARKET_BY_PIG_GROUP_ID_SELECT] TO [db_sp_exec]
    AS [dbo];


-- =========================================================
-- Author:		Brian Cesafsky
-- Create date: 06/12/2008
-- Description:	Returns augers based on active column value
-- =========================================================
CREATE PROCEDURE [dbo].[cfp_AUGER_SELECT_BY_STATUS]
(
	@Active		bit
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT AugerID
	    ,Size
FROM dbo.cft_AUGER (NOLOCK)
WHERE Active = @Active
Order By Size
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_AUGER_SELECT_BY_STATUS] TO [db_sp_exec]
    AS [dbo];


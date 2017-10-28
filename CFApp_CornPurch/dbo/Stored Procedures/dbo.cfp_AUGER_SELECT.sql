-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 04/16/2008
-- Description:	Returns all augers
-- =============================================
CREATE PROCEDURE [dbo].[cfp_AUGER_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT AugerID
	    ,Size
		,Active
FROM dbo.cft_AUGER
Order By Active, Size
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_AUGER_SELECT] TO [db_sp_exec]
    AS [dbo];


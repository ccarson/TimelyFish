-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 03/16/2008
-- Description:	Returns all Contact Status Types
-- =============================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_STATUS_TYPE_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT StatusID
		, Description
FROM dbo.cft_STATUS_TYPE
Order By Description
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_STATUS_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];


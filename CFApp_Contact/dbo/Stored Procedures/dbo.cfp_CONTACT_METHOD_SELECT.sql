-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 04/16/2008
-- Description:	Returns all Contact methods
-- =============================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_METHOD_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT ContactMethodID
		, Description
FROM dbo.cft_CONTACT_METHOD_TYPE
Order By Description
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_METHOD_SELECT] TO [db_sp_exec]
    AS [dbo];


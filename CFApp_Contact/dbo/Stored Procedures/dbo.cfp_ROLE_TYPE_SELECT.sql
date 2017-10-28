-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 07/16/2009
-- Description:	Returns all Role Types
-- =============================================
CREATE PROCEDURE [dbo].[cfp_ROLE_TYPE_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT RoleTypeID
	  ,RoleTypeDescription
FROM dbo.cft_ROLE_TYPE (NOLOCK)
Order By RoleTypeDescription
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_ROLE_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];


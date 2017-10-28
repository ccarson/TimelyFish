-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 07/16/2009
-- Description:	Returns all Contact Types
-- =============================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_TYPE_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT ContactTypeID
		  ,ContactTypeDescription
	FROM dbo.cft_CONTACT_TYPE (NOLOCK)
	Order By ContactTypeDescription
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];


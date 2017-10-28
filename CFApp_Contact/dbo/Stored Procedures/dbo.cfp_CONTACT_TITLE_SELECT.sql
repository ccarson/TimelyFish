-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 07/16/2009
-- Description:	Returns all Contact Titles
-- =============================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_TITLE_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT ContactTitleID
		  ,ContactTitleDescription
	FROM dbo.cft_CONTACT_TITLE (NOLOCK)
	Order By ContactTitleDescription
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_TITLE_SELECT] TO [db_sp_exec]
    AS [dbo];


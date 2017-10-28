-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 04/22/2008
-- Description:	Returns all Contact Phone Types
-- =============================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_PHONE_TYPE_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT PhoneTypeID
		, Description
FROM dbo.cft_PHONE_TYPE
Order By Description
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_PHONE_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];


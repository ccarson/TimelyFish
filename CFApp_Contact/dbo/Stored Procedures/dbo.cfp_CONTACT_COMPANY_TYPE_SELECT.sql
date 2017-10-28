-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 07/02/2009
-- Description:	Returns all Contact Company Types
-- =============================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_COMPANY_TYPE_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT CompanyTypeID
	  ,CompanyTypeDescription
FROM dbo.cft_CONTACT_COMPANY_TYPE (NOLOCK)
Order By CompanyTypeDescription
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_COMPANY_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];


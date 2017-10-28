-- =============================================
-- Author:	Brian Cesafsky
-- Create date: 02/14/2008
-- Description:	select site wash record by contact ID
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SITE_WASH_SELECT_BY_CONTACT]	
(
	@ContactID				int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		SiteWash.SiteWashID,
		SiteWash.ContactID, 
		Contact.ContactName,
		SiteWash.WashFromEffectDate,
		SiteWash.WashToEffectDate,
		SiteWash.CreatedDateTime,
		SiteWash.CreatedBy,
		SiteWash.UpdatedDateTime,
		SiteWash.UpdatedBy
	FROM dbo.cft_SITE_WASH SiteWash (NOLOCK)
	INNER JOIN [$(CentralData)].dbo.Contact Contact (NOLOCK)
		ON Contact.ContactID = SiteWash.ContactID
	WHERE SiteWash.ContactID = @ContactID
	ORDER BY Contact.ContactName
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_WASH_SELECT_BY_CONTACT] TO [db_sp_exec]
    AS [dbo];


-- =============================================
-- Author:		<Brian Cesafsky>
-- Create date: <10/17/2007>
-- Description:	<Selects a Packer record>
-- =============================================
CREATE PROCEDURE [dbo].[cfp_PACKER_SELECT]	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select packer.ContactID, contact.ContactName
	from [$(CentralData)].dbo.Packer packer (NOLOCK)
	inner join [$(CentralData)].dbo.Contact contact (NOLOCK)
	on Contact.ContactID = packer.ContactID
	Order By contact.ContactName
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_SELECT] TO [db_sp_exec]
    AS [dbo];


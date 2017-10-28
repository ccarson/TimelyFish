-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 03/22/2008
-- Description:	Returns all addresses by contactID
-- =============================================
CREATE PROCEDURE [dbo].[cfp_ADDRESS_SELECT_BY_CONTACTID]
(
	@ContactID		int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT cft_ADDRESS.AddressID
		,cft_ADDRESS.EmailAddress
		,cft_ADDRESS.Address1
		,cft_ADDRESS.Address2
		,cft_ADDRESS.City
		,cft_ADDRESS.State
		,cft_ADDRESS.Zip
		,cft_ADDRESS.Country
		,cft_ADDRESS.Longitude
		,cft_ADDRESS.Latitude
		,cft_ADDRESS.County
		,cft_ADDRESS.Township
		,cft_ADDRESS.SectionNbr
		,cft_ADDRESS.Range
		,cft_CONTACT_ADDRESS.AddressTypeID
from dbo.cft_ADDRESS cft_ADDRESS
		INNER JOIN dbo.cft_CONTACT_ADDRESS cft_CONTACT_ADDRESS ON cft_CONTACT_ADDRESS.AddressID = cft_ADDRESS.AddressID
WHERE   (cft_CONTACT_ADDRESS.ContactID = @ContactID)
ORDER BY cft_ADDRESS.City
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_ADDRESS_SELECT_BY_CONTACTID] TO [db_sp_exec]
    AS [dbo];


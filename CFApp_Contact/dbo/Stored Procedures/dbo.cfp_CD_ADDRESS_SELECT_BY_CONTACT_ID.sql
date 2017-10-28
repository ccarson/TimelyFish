-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 06/29/2009
-- Description:	CENTRAL DATA - Returns all addresses by contact ID 
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_CD_ADDRESS_SELECT_BY_CONTACT_ID]
(
	@ContactID		int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT Address.AddressID
		,Address.Address1
		,Address.Address2
		,Address.City
		,Address.State
		,Address.Zip
		,Address.Country
		,Address.Longitude
		,Address.Latitude
		,Address.County
		,Address.Township
		,Address.SectionNbr
		,Address.Range
		,ContactAddress.AddressTypeID
	FROM [$(CentralData)].dbo.Address Address (NOLOCK)
		 INNER JOIN [$(CentralData)].dbo.ContactAddress ContactAddress (NOLOCK)
			ON ContactAddress.AddressID = Address.AddressID
	WHERE (ContactAddress.ContactID = @ContactID)
	ORDER BY Address.City
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_ADDRESS_SELECT_BY_CONTACT_ID] TO [db_sp_exec]
    AS [dbo];


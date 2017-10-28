-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 09/17/2009
-- Description:	CENTRAL DATA - Returns all addresses by address type 
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_CD_MAP_ADDRESS_SELECT_BY_ADDRESS_TYPE]
(
	@AddressTypeID		int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT Address.AddressID
		, Address.Latitude
		, Address.Longitude
		, Address.Address1
		, Address.Address2
		, Address.City
		, Address.State
		, Address.Zip
		, Contact.ContactID 
		, Contact.ContactName 
	FROM [$(CentralData)].dbo.Contact Contact (NOLOCK)
	INNER JOIN [$(CentralData)].dbo.ContactAddress ContactAddress (NOLOCK)
		ON Contact.ContactID=ContactAddress.ContactID
	INNER JOIN [$(CentralData)].dbo.Address Address (NOLOCK)
		ON ContactAddress.AddressID=Address.AddressID
	WHERE ContactAddress.AddressTypeID=@AddressTypeID
		AND (Address.Longitude IS NOT NULL) 
		AND (Address.Latitude <> 0) 
		AND (Address.Longitude IS NOT NULL) 
		AND (Address.Latitude <> 0)
		AND Contact.StatusTypeID = 1 --Active
	ORDER BY Contact.ContactName;
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_MAP_ADDRESS_SELECT_BY_ADDRESS_TYPE] TO [db_sp_exec]
    AS [dbo];


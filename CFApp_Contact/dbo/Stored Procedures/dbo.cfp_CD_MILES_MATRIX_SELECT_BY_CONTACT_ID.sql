-- =============================================================================
-- Author:		Brian Cesafsky
-- Create date: 09/16/2009
-- Description:	CENTRAL DATA - Returns all miles matrix records by contact ID 
-- Change:  Added Directions  (ddahle) 8/5/2015
-- =============================================================================
CREATE PROCEDURE [dbo].[cfp_CD_MILES_MATRIX_SELECT_BY_CONTACT_ID]
(
	@ContactID		int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ContactFrom.ContactName AS FromContactName,
		MilesMatrix.AddressIDFrom AS AddressIDFrom,
		ContactTo.ContactName AS ToContactName,
		ContactTo.ContactID AS ToContactID,
		MilesMatrix.AddressIDTo AS AddressIDTo,
		MilesMatrix.OneWayMiles,
		MilesMatrix.RestrictOneWayMiles,
		MilesMatrix.OneWayHours,
		MilesMatrix.RestrictOneWayHours,
		MilesMatrix.OverRide, 
		MilesMatrix.Directions
	FROM [$(CentralData)].dbo.MilesMatrix AS MilesMatrix
	INNER JOIN  [$(CentralData)].dbo.Address AS AddressFrom
		  ON MilesMatrix.AddressIDFrom=AddressFrom.AddressID
	INNER JOIN [$(CentralData)].dbo.ContactAddress AS ContactAddress
		  ON AddressFrom.AddressID=ContactAddress.AddressID
	INNER JOIN [$(CentralData)].dbo.Contact AS ContactFrom
		  ON ContactAddress.ContactID=ContactFrom.ContactID 
	INNER JOIN  [$(CentralData)].dbo.Address AS AddressTo 
		  ON MilesMatrix.AddressIDTo=AddressTo.AddressID
	INNER JOIN [$(CentralData)].dbo.ContactAddress AS ContactAddressTo 
		  ON AddressTo.AddressID=ContactAddressTo.AddressID
	INNER JOIN [$(CentralData)].dbo.Contact AS ContactTo 
		  ON ContactAddressTo.ContactID=ContactTo.ContactID 
	WHERE ContactAddressTo.AddressTypeID=1 
	And ContactFrom.ContactID = @ContactID  --2526
	GROUP BY 
		  ContactFrom.ContactName,
		  MilesMatrix.AddressIDFrom,
		  ContactTo.ContactName,
		  ContactTo.ContactID,
		  MilesMatrix.AddressIDTo,
		  MilesMatrix.OneWayMiles,
		  MilesMatrix.RestrictOneWayMiles,
		  MilesMatrix.OneWayHours,
		  MilesMatrix.RestrictOneWayHours,
		  MilesMatrix.OverRide,
		  MilesMatrix.Directions
	ORDER BY ContactTo.ContactName
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_MILES_MATRIX_SELECT_BY_CONTACT_ID] TO [db_sp_exec]
    AS [dbo];


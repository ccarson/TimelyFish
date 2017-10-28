-- ===================================================================================================
-- Author:		Brian Cesafsky
-- Create date: 05/17/2010
-- Description:	CENTRAL DATA - Returns all miles matrix records that have the over-ride flag = TRUE 
-- ===================================================================================================
CREATE PROCEDURE [dbo].[cfp_CD_MILES_MATRIX_SELECT_OVERRIDE]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ContactFrom.ContactName AS FromContactName,
		ContactFrom.ContactID AS FromContactID,
		MilesMatrix.AddressIDFrom AS AddressIDFrom,
		AddressFrom.Latitude AS AddressFromLatitude,
		AddressFrom.Longitude AS AddressFromLongitude,
		ContactTo.ContactName AS ToContactName,
		ContactTo.ContactID AS ToContactID,
		MilesMatrix.AddressIDTo AS AddressIDTo,
		AddressTo.Latitude AS AddressToLatitude,
		AddressTo.Longitude AS AddressToLongitude,
		MilesMatrix.OneWayMiles,
		MilesMatrix.RestrictOneWayMiles,
		MilesMatrix.OneWayHours,
		MilesMatrix.RestrictOneWayHours,
		MilesMatrix.OverRide 
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
	WHERE MilesMatrix.OverRide <> 0
	AND ContactAddressTo.AddressTypeID=1 
	AND ContactFrom.StatusTypeID=1
	AND ContactTo.StatusTypeID=1
	AND AddressFrom.Latitude is not null
	AND	AddressFrom.Longitude is not null
	AND AddressTo.Latitude is not null
	AND	AddressTo.Longitude is not null
	--And ContactFrom.ContactID = 2526
	GROUP BY 
		  ContactFrom.ContactName,
		  ContactFrom.ContactID,
		  MilesMatrix.AddressIDFrom,
		  AddressFrom.Latitude,
		  AddressFrom.Longitude,
		  ContactTo.ContactName,
		  ContactTo.ContactID,
		  MilesMatrix.AddressIDTo,
		  AddressTo.Latitude,
		  AddressTo.Longitude,
		  MilesMatrix.OneWayMiles,
		  MilesMatrix.RestrictOneWayMiles,
		  MilesMatrix.OneWayHours,
		  MilesMatrix.RestrictOneWayHours,
		  MilesMatrix.OverRide 
	ORDER BY ContactFrom.ContactName
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_MILES_MATRIX_SELECT_OVERRIDE] TO [db_sp_exec]
    AS [dbo];


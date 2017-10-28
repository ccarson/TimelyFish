-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 06/29/2009
-- Description:	CENTRAL DATA - Returns all addresses by contact ID 
-- Change:  Added ContactFromName and ContactToName  (ddahle) 7/23/2015
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_CD_MILES_MATRIX_ADDITIONS_SELECT]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT AddressFrom.AddressID AS AddressFromID
		, AddressFrom.Latitude AS AddressFromLatitude
		, AddressFrom.Longitude AS AddressFromLongitude
		, AddressTo.AddressID AS AddressToID
		, AddressTo.Latitude AS AddressToLatitude
		, AddressTo.Longitude AS AddressToLongitude
		, ContactFrom.ContactName AS FromContactName
		, ContactTo.ContactName AS ToContactName
	FROM  [$(CentralData)].dbo.Address AS AddressFrom (NOLOCK)
		INNER JOIN  [$(CentralData)].dbo.Address AS AddressTo (NOLOCK) 
			ON AddressFrom.AddressID <> AddressTo.AddressID 
		LEFT OUTER JOIN  [$(CentralData)].dbo.MilesMatrix AS MilesMatrix (NOLOCK) 
			ON AddressFrom.AddressID = MilesMatrix.AddressIDFrom 
			AND AddressTo.AddressID = MilesMatrix.AddressIDTo
		INNER JOIN [$(CentralData)].dbo.ContactAddress AS ContactAddressFrom
			ON AddressFrom.AddressID=ContactAddressFrom.AddressID
		INNER JOIN [$(CentralData)].dbo.Contact AS ContactFrom
			ON ContactAddressFrom.ContactID=ContactFrom.ContactID 
		INNER JOIN [$(CentralData)].dbo.ContactAddress AS ContactAddressTo 
			ON AddressTo.AddressID=ContactAddressTo.AddressID
		INNER JOIN [$(CentralData)].dbo.Contact AS ContactTo 
			ON ContactAddressTo.ContactID=ContactTo.ContactID 
	WHERE (MilesMatrix.OneWayMiles IS NULL) 
		AND (AddressFrom.Longitude IS NOT NULL) 
		AND (AddressFrom.Latitude <> 0) 
		AND (AddressTo.Longitude IS NOT NULL) 
		AND (AddressTo.Latitude <> 0)
		AND (ContactFrom.StatusTypeID = 1)
		AND (ContactTo.StatusTypeID = 1)
	GROUP BY 
		  AddressFrom.AddressID 
		, AddressFrom.Latitude 
		, AddressFrom.Longitude 
		, AddressTo.AddressID
		, AddressTo.Latitude 
		, AddressTo.Longitude
		, ContactFrom.ContactName
		, ContactTo.ContactName
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_MILES_MATRIX_ADDITIONS_SELECT] TO [db_sp_exec]
    AS [dbo];


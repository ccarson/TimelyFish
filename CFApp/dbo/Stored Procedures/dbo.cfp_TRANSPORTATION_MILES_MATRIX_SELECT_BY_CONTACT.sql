-- ========================================================
-- Author:		Brian Cesafsky
-- Create date: 01/15/2008
-- Description:	Selects miles matrix
-- ========================================================
CREATE PROCEDURE [dbo].[cfp_TRANSPORTATION_MILES_MATRIX_SELECT_BY_CONTACT]
(
	@ContactIDSource				char(6),
	@ContactIDDestination			char(6),
	@AddressTypeIDSource			char(2),
	@AddressTypeIDDestination		char(2)
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT cSource.ContactID AS SourceSite
			, cDest.ContactID AS DestSite
			, MIN(mm.OneWayHours) AS OneWayHours
			, MIN(mm.OneWayMiles) AS OneWayMiles
	FROM [$(SolomonApp)].dbo.cftMilesMatrix AS mm WITH (NOLOCK) 
		INNER JOIN [$(SolomonApp)].dbo.cftContactAddress AS cSource WITH (NOLOCK) ON mm.AddressIDFrom = cSource.AddressID AND cSource.AddressTypeID = @AddressTypeIDSource 
		INNER JOIN [$(SolomonApp)].dbo.cftContactAddress AS cDest WITH (NOLOCK) ON mm.AddressIDTo = cDest.AddressID AND cDest.AddressTypeID = @AddressTypeIDDestination
	WHERE cSource.ContactID = @ContactIDSource
	AND cDest.ContactID = @ContactIDDestination
	GROUP BY cSource.ContactID, cDest.ContactID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_TRANSPORTATION_MILES_MATRIX_SELECT_BY_CONTACT] TO [db_sp_exec]
    AS [dbo];


-- ======================================================================
-- Author:		Brian Cesafsky
-- Create date: 07/07/2010
-- Description:	Returns data for the Site To Packer Mileage report
-- ======================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SITE_TO_PACKER_MILEAGE]
(
	@MovementStartDate		DateTime
	,@MovementEndDate		DateTime
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT distinct
		cftPM.SourceContactID
		,SourceContact.ContactName SourceContact
		,DestContact.ContactID DestContactID
		,DestContact.ContactName DestContact
		,MilesMatrix.OneWayMiles AS OneWayMiles
	FROM SolomonApp.dbo.cftPM cftPM (nolock)
	JOIN CentralData.dbo.Contact DestContact (NOLOCK)
		ON DestContact.ContactID in ('000554', '000555', '000823', '002936')
		--Swift-Marshalltown, Swift-Worthington, IBP Waterloo, Triumph Foods
	JOIN CentralData.dbo.Contact SourceContact (NOLOCK)
		ON SourceContact.ContactID = CAST(cftPM.SourceContactID AS INT)
	JOIN CentralData.dbo.ContactAddress DestContactAddress (NOLOCK)
		ON DestContactAddress.ContactID = DestContact.ContactID
		AND DestContactAddress.AddressTypeID = 1
	JOIN CentralData.dbo.ContactAddress SourceContactAddress (NOLOCK)
		ON SourceContactAddress.ContactID = CAST(cftPM.SourceContactID AS INT)
		AND SourceContactAddress.AddressTypeID = 1
	JOIN CentralData.dbo.MilesMatrix MilesMatrix (NOLOCK)
		ON (MilesMatrix.AddressIDFrom = SourceContactAddress.AddressID
		AND MilesMatrix.AddressIDTo = DestContactAddress.AddressID)
	WHERE cftPM.MovementDate BETWEEN @MovementStartDate AND @MovementEndDate
	AND cftPM.PMTypeID <> '01'
	ORDER BY SourceContact.ContactName, DestContact.ContactName
END


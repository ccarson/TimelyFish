--*************************************************************
--	Purpose:MilesMatrix with COntactIDs
--	Author: Charity Anderson
--	Date: 3/6/2005
--	Usage: Transportaton
--	Parms: 
--	      
--*************************************************************

CREATE VIEW dbo.vCFContactMilesMatrix
	
	
AS

SELECT     cSource.ContactID AS SourceSite, cDest.ContactID AS DestSite, min(mm.OneWayHours) as OneWayHours, Min(mm.OneWayMiles) as OneWayMiles
FROM         dbo.cftMilesMatrix mm WITH (NOLOCK) 
                JOIN dbo.cftContactAddress cSource WITH (NOLOCK) ON mm.AddressIDFrom = cSource.AddressID and cSource.AddressTypeID='01'
		JOIN dbo.cftContactAddress cDest WITH (NOLOCK) ON mm.AddressIDTo = cDest.AddressID and cDest.AddressTypeID='01'
		Group By cSource.ContactID, cDest.ContactID

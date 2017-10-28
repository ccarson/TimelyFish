
----------------------------------------------------------------------------------------
--	Purpose: Detail view for bin readings on a Sow Farm
--	Author: Timothy Jones
--	Date: 
--	Program Usage: Essbase File Builder for Sow Data
--	Parms: 
--  Revised : Sue Matter
--  Date:  8/13/2007
--  Purpose:  Use Temp tables in SowData that are prefilled at run time
----------------------------------------------------------------------------------------



CREATE VIEW [dbo].[vBinReadingDetail]
	AS
	SELECT br.BinNbr, br.BinReadingDate, br.SiteContactID, c.ContactName, 
	Pounds = br.Tons * 2000, -- Convert since deliveries are in pounds
	b.BarnNbr, ba.DfltRation
	from cftBinReadingTemp br
	JOIN cftContactTemp c ON br.SiteContactID=c.ContactID
	JOIN cftBinTemp b ON br.SiteContactID=b.ContactID AND br.BinNbr=b.BinNbr
	JOIN cftBarnTemp ba ON b.ContactID = ba.ContactID AND b.BarnNbr=ba.BarnNbr
	WHERE ba.FacilityTypeID = '001'  -- Sow Farms


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vBinReadingDetail] TO [se\analysts]
    AS [dbo];


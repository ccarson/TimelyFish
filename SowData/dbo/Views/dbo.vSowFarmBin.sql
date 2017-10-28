
----------------------------------------------------------------------------------------
--	Purpose: Detail view for bins on a SowFarm
--	Author: Timothy Jones
--	Date: 
--	Program Usage: Essbase File Builder for Sow Data
--	Parms: 
--  Revised : Sue Matter
--  Date:  8/13/2007
--  Purpose:  Use Temp tables in SowData that are prefilled at run time
----------------------------------------------------------------------------------------

CREATE VIEW [dbo].[vSowFarmBin]
	AS
SELECT b.BinNbr, b.ContactID, c.ContactName, ba.DfltRation,
      RationType = (SELECT CASE Left(DfltRation,2) WHEN '02' THEN 'Gestation' WHEN '03' THEN 'Lactation' ELSE 'N/A' END)
      from cftBinTemp b
      JOIN cftContactTemp c ON b.ContactID=c.ContactID
      JOIN cftBarnTemp ba ON b.ContactID = ba.ContactID AND b.BarnNbr=ba.BarnNbr
      WHERE (ba.FacilityTypeID = '001' or b.ContactID in ('001477', '001476')) -- Sow Farms
      AND LEFT(DfltRation,2) In('02','03') -- Gestation (02) and Lactation (03) Rations

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowFarmBin] TO [se\analysts]
    AS [dbo];


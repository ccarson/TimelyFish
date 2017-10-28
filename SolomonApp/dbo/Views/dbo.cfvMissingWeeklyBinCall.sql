
CREATE  VIEW dbo.cfvMissingWeeklyBinCall AS

--*************************************************************
--	Purpose: Missing Weekly Call-Ins for Bin Readings
--	Author: Eric Lind
--	Date: 4/29/2005
--	Usage: Missing Weekly Bin Call Report
--	
--*************************************************************

SELECT pg.SiteContactID, pg.PigGroupID, bin.BinNbr,
	 max(brd.BinReadingDate) As LastReading

FROM cftPigGroup pg
JOIN cftBarn brn ON brn.ContactID = pg.SiteContactID AND brn.BarnNbr = pg.BarnNbr
JOIN cftBin bin on bin.ContactID = brn.ContactID AND bin.BarnNbr = brn.BarnNbr
LEFT JOIN cftBinReading brd ON brd.SiteContactID = bin.ContactID AND brd.BinNbr = bin.BinNbr

WHERE pg.PGStatusID IN ('A', 'T')

GROUP BY pg.SiteContactID, pg.PigGroupID, bin.BinNbr





 
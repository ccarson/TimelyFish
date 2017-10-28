----------------------------------------------------------------------------------------
--	Purpose: Detail view for weekly bin readings and feed
--	Author: Timothy Jones
--	Date: 
--	Program Usage: Essbase File Builder for Sow Data
--	Parms: 
--  Revised : Sue Matter
--  Date:  8/13/2007
--  Purpose:  Use Temp tables in SowData that are prefilled at run time
----------------------------------------------------------------------------------------


CREATE VIEW [dbo].[vFarmBinForEachWeekWithReading]
	AS 
	SELECT v.*, 
	--BegBinReadingDate=(Select TOP 1 BinReadingDate From vBinReadingDetail WHERE v.ContactID = SiteContactID AND v.BinNbr = BinNbr AND BinReadingDate BETWEEN v.WeekOfDate-7	AND v.WeekEndDate-7 ORDER BY BinReadingDate), -- OLDEST (Closest to Wednesday of prior week date)
	BegBinPounds=IsNull((Select TOP 1 Pounds From vBinReadingDetail 
				WHERE v.ContactID = SiteContactID AND v.BinNbr = BinNbr 
				AND BinReadingDate BETWEEN v.WeekOfDate-5 
				AND v.WeekEndDate-3 ORDER BY BinReadingDate Desc),0), -- OLDEST (Closest to Wednesday of prior week date) +/- 1 day on either side of previous Wednesday
	--EndBinReadingDate=(Select TOP 1 BinReadingDate From vBinReadingDetail WHERE v.ContactID = SiteContactID AND v.BinNbr = BinNbr AND BinReadingDate BETWEEN v.WeekOfDate AND v.WeekEndDate ORDER BY BinReadingDate DESC), -- NEWEST (Closest to Tuesday of current week date)
	EndBinPounds=IsNull((Select TOP 1 Pounds From vBinReadingDetail WHERE v.ContactID = SiteContactID 
			AND v.BinNbr = BinNbr 
			AND BinReadingDate BETWEEN v.WeekOfDate+2 AND v.WeekEndDate+4 ORDER BY BinReadingDate DESC),0), -- NEWEST (Closest to Tuesday of current week date) +/- 1 day on either side of current Wednesday
	DeliveredPounds=IsNull((Select Sum(QtyDel) 
				FROM cftFeedOrderTemp fo
				WHERE fo.ContactID = v.ContactID 
				AND fo.BinNbr = v.BinNbr
				AND fo.DateDel BETWEEN (v.WeekOfDate - 4) --Wednesday of previous week
							AND (v.WeekOfDate+2) --Tuesday of current week
				),0)
	FROM vSowFarmBinForEachWeek v



GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vFarmBinForEachWeekWithReading] TO [se\analysts]
    AS [dbo];


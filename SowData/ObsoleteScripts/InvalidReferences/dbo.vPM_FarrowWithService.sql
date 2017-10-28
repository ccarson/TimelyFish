CREATE VIEW dbo.vPM_FarrowWithService
	AS

 SELECT sfe.SiteID, sfe.WeekOfDate, sfe.SowGenetics, sfe.SowParity, Count(*) As Qty
	FROM SowFarrowEvent sfe
	LEFT JOIN SowMatingEvent sme On sfe.SiteID = sme.SiteID AND sfe.SowID = sme.SowID
		AND sme.EventDate Between sfe.EventDate-125 AND sfe.EventDate-105
	WHERE sme.SowID is Not Null and sme.MatingNbr = 1
	Group By sfe.SiteID, sfe.WeekOfDate, sfe.SowGenetics, sfe.SowParity

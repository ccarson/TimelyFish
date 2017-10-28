CREATE VIEW [dbo].[vPM_ServiceToFarrowBaseDetail_119] (FarmID, WeekOfDate, SowID, SowGenetics, SowParity)
	As
 SELECT sme.FarmID, wd.WeekOfDate, sme.SowId, sme.SowGenetics, sme.SowParity
	FROM dbo.WeekDefinition wd
	LEFT JOIN dbo.SowMatingEvent sme ON sme.EventDate Between (wd.WeekOfDate - 115) And (wd.WeekofDate - 109)
	WHERE sme.MatingNbr = 1 
		AND sme.SowID Not In(SELECT Distinct SowID FROM dbo.SowFarrowEvent
			Where FarmID = sme.FarmID 
			AND SowID = sme.SowID 
			AND (
				(EventDate Between (wd.WeekOfDate - 7) AND (wd.WeekOfDate-1)) 
				 OR
			     	(EventDate Between (wd.WeekOfDate + 7) AND (wd.WeekOfDate+13)) 
			)) 
 UNION
 SELECT sfe.FarmID, sfe.WeekOfDate, sfe.SowID, sfe.SowGenetics, sfe.SowParity
	FROM dbo.SowFarrowEvent sfe

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_ServiceToFarrowBaseDetail_119] TO [se\analysts]
    AS [dbo];


CREATE VIEW [vPM2_ServiceToFarrowBaseDetail_115] (FarmID, WeekOfDate, SowID, SowGenetics, SowParity)
	As
 SELECT sme.FarmID, wd.WeekOfDate, sme.SowId, sme.SowGenetics, sme.SowParity
	FROM WeekDefinitionTemp wd WITH (NOLOCK)
	LEFT JOIN SowMatingEventTemp sme WITH (NOLOCK)ON sme.EventDate Between (wd.WeekOfDate - 115) And (wd.WeekofDate - 109)
	WHERE sme.MatingNbr = 1 
		AND sme.SowID Not In(SELECT Distinct SowID FROM SowFarrowEventTemp WITH (NOLOCK)
			Where FarmID = sme.FarmID 
			AND SowID = sme.SowID 
			AND (
				(EventDate Between (wd.WeekOfDate - 7) AND (wd.WeekOfDate-1)) 
				 OR
			     	(EventDate Between (wd.WeekOfDate + 7) AND (wd.WeekOfDate+13)) 
			)) 
 UNION
 SELECT sfe.FarmID, sfe.WeekOfDate, sfe.SowID, sfe.SowGenetics, sfe.SowParity
	FROM SowFarrowEventTemp sfe WITH (NOLOCK)

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_ServiceToFarrowBaseDetail_115] TO [se\analysts]
    AS [dbo];


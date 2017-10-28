CREATE VIEW [vPM2_SowServicesWithFalloutDetail]
As
	SELECT sme.FarmID, sme.SowID, sme.WeekOfDate, sme.SowGenetics, sme.SowParity, sme.EventDate, 
		Type = 'Removal', Days = datediff(day,sme.EventDate, s.RemovalDate)
		FROM SowMatingEventTemp sme WITH (NOLOCK)
		JOIN SowTemp s WITH (NOLOCK) ON sme.FarmID = s.FarmID and sme.SowID = s.SowID
		LEFT JOIN SowFarrowEventTemp sfe WITH (NOLOCK) on sme.FarmID = sfe.FarmID and sme.SowID = sfe.SowID and sfe.EventDate BETWEEN (sme.EventDate + 95) AND (sme.EventDate + 135) AND
			sme.SowParity + 1 = sfe.SowParity
		Where sme.MatingNbr = 1 and sfe.FarmID is null  -- only pickup the fallout
	UNION
	SELECT sme.FarmID, sme.SowID, sme.WeekOfDate, sme.SowGenetics, sme.SowParity, sme.EventDate, 
		Type = 'RepeatMate', Days = datediff(day,sme.EventDate,(SELECT Min(EventDate) FROM SowMatingEventTemp Where FarmID = sme.FarmID
			and SowID = sme.SowID AND SowParity = sme.SowParity and EventDate > sme.EventDate and MatingNbr = 1))
		FROM SowMatingEventTemp sme WITH (NOLOCK)
		JOIN SowTemp s WITH (NOLOCK) ON sme.FarmID = s.FarmID and sme.SowID = s.SowID
		LEFT JOIN SowFarrowEventTemp sfe WITH (NOLOCK) on sme.FarmID = sfe.FarmID and sme.SowID = sfe.SowID and sfe.EventDate BETWEEN (sme.EventDate + 95) AND (sme.EventDate + 135) AND
			sme.SowParity + 1 = sfe.SowParity
		Where sme.MatingNbr = 1 and sfe.FarmID is null  -- only pickup the fallout
	UNION
	SELECT sme.FarmID, sme.SowID, sme.WeekOfDate, sme.SowGenetics, sme.SowParity, sme.EventDate, 
		Type = 'Fallout', Days = datediff(day,sme.EventDate,(SELECT Min(EventDate) FROM SowFalloutEventTemp Where FarmID = sme.FarmID
			and SowID = sme.SowID AND SowParity = sme.SowParity and EventDate > sme.EventDate))
		FROM SowMatingEventTemp sme WITH (NOLOCK)
		JOIN SowTemp s WITH (NOLOCK) ON sme.FarmID = s.FarmID and sme.SowID = s.SowID
		LEFT JOIN SowFarrowEventTemp sfe WITH (NOLOCK) on sme.FarmID = sfe.FarmID and sme.SowID = sfe.SowID and sfe.EventDate BETWEEN (sme.EventDate + 95) AND (sme.EventDate + 135) AND
			sme.SowParity + 1 = sfe.SowParity
		Where sme.MatingNbr = 1 and sfe.FarmID is null  -- only pickup the fallout
	UNION
	SELECT sme.FarmID, sme.SowID, sme.WeekOfDate, sme.SowGenetics, sme.SowParity, sme.EventDate, 
		Type = 'PregNeg', Days = datediff(day,sme.EventDate,(SELECT Min(EventDate) FROM SowPregExamEventTemp Where FarmID = sme.FarmID
			and SowID = sme.SowID AND SowParity = sme.SowParity and EventDate > sme.EventDate))
		FROM SowMatingEventTemp sme WITH (NOLOCK)
		JOIN SowTemp s WITH (NOLOCK) ON sme.FarmID = s.FarmID and sme.SowID = s.SowID
		LEFT JOIN SowFarrowEventTemp sfe WITH (NOLOCK) on sme.FarmID = sfe.FarmID and sme.SowID = sfe.SowID and sfe.EventDate BETWEEN (sme.EventDate + 95) AND (sme.EventDate + 135) AND
			sme.SowParity + 1 = sfe.SowParity
		Where sme.MatingNbr = 1 and sfe.FarmID is null  -- only pickup the fallout

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_SowServicesWithFalloutDetail] TO [se\analysts]
    AS [dbo];


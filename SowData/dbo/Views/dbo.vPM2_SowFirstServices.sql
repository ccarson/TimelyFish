CREATE VIEW [vPM2_SowFirstServices] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
 SELECT sme.FarmID, sme.WeekOfDate, sme.SowGenetics, sme.SowParity, count(*)
	FROM SowMatingEventTemp sme WITH (NOLOCK)
	where SowID Not In
		(SELECT distinct sowid FROM SowMatingEventTemp WITH (NOLOCK) where sowid = sme.sowid and FarmID = sme.FarmID and matingnbr = 1 and SowParity = sme.SowParity and eventdate < sme.eventdate)
	and matingnbr = 1 and Sowparity > 0
	group By sme.FarmID, sme.WeekOfDate, sme.SowGenetics, sme.SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_SowFirstServices] TO [se\analysts]
    AS [dbo];


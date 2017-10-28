CREATE VIEW [dbo].[vPM_GiltFirstServices] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
 SELECT sme.FarmID, sme.WeekOfDate, sme.SowGenetics, sme.SowParity, count(*)
	FROM dbo.SowMatingEvent sme
	where SowID Not In
		(SELECT distinct SowId FROM dbo.SowMatingEvent where SowId = sme.SowId and FarmID = sme.FarmID and MatingNbr = 1 and SowParity = sme.SowParity and Eventdate < sme.Eventdate)
	and MatingNbr = 1 and SowParity = 0
	group By sme.FarmID, sme.WeekOfDate, sme.SowGenetics, sme.SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_GiltFirstServices] TO [se\analysts]
    AS [dbo];


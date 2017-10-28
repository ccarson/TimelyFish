CREATE VIEW [dbo].[vPM_PigDeathsOfLittersWeanedBase] (FarmID, SowID, WeekOfDate, EventDate, SowParity, SowGenetics, Qty)
	AS
	SELECT *, Qty = (SELECT sum(Qty) FROM dbo.SowPigletDeathEvent
	Where FarmID = v.FarmID AND SowID = v.SowID and SowParity = v.SowParity)
	FROM dbo.vPM_LittersWeanedWithNurseOffBase v 

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_PigDeathsOfLittersWeanedBase] TO [se\analysts]
    AS [dbo];


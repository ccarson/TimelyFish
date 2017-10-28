CREATE VIEW [vPM2_PigDeathsOfLittersWeanedBase] (FarmID, SowID, WeekOfDate, EventDate, SowParity, SowGenetics, Qty)
	AS
	SELECT *, Qty = (SELECT sum(Qty) FROM SowPigletDeathEventTemp WITH (NOLOCK)
	Where FarmID = v.FarmID AND SowID = v.SowID and SowParity = v.SowParity)
	FROM vPM2_LittersWeanedWithNurseOffBase v WITH (NOLOCK)

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_PigDeathsOfLittersWeanedBase] TO [se\analysts]
    AS [dbo];


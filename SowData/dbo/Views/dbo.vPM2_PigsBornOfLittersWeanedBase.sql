CREATE VIEW [vPM2_PigsBornOfLittersWeanedBase] (FarmID, SowID, WeekOfDate, EventDate, SowParity, SowGenetics, Qty)
	AS
	SELECT *, Qty = (SELECT sum(QtyBornAlive) FROM SowFarrowEventTemp WITH (NOLOCK)
	Where FarmID = v.FarmID AND SowID = v.SowID and SowParity = v.SowParity)
	FROM vPM2_LittersWeanedWithNurseOffBase v WITH (NOLOCK)

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_PigsBornOfLittersWeanedBase] TO [se\analysts]
    AS [dbo];


CREATE VIEW [dbo].[vPM_PigsBornOfLittersWeanedBase] (FarmID, SowID, WeekOfDate, EventDate, SowParity, SowGenetics, Qty)
	AS
	SELECT *, Qty = (SELECT sum(QtyBornAlive) FROM dbo.SowFarrowEvent
	Where FarmID = v.FarmID AND SowID = v.SowID and SowParity = v.SowParity)
	FROM dbo.vPM_LittersWeanedWithNurseOffBase v 

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_PigsBornOfLittersWeanedBase] TO [se\analysts]
    AS [dbo];


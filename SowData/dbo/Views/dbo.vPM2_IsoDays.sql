CREATE VIEW vPM2_IsoDays (FarmID,WeekOfDate,Qty)
	AS
	select FarmID,WeekOfDate,
	Qty = Sum(QtyOnHand)
	FROM vPM2_IsoDaysDetail v
	JOIN WeekDefinition wd ON v.EffectiveDate BETWEEN wd.WeekOfDate AND wd.WeekEndDate
	GROUP BY FarmID, WeekOfDate

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_IsoDays] TO [se\analysts]
    AS [dbo];


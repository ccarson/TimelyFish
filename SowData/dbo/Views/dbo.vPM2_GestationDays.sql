CREATE VIEW vPM2_GestationDays (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
AS
select farmid, weekofdate, sowgenetics, sowparity, qty = count(*)
	FROM vPM2_GestationDayDetail WITH (NOLOCK)
	GROUP BY farmid, weekofdate, sowgenetics, sowparity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_GestationDays] TO [se\analysts]
    AS [dbo];


CREATE VIEW vPM2_LactationDays (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
AS
select farmid, weekofdate, sowgenetics, sowparity, qty = count(*)
	FROM vPM2_LactationDayDetail WITH (NOLOCK)
	GROUP BY farmid, weekofdate, sowgenetics, sowparity


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_LactationDays] TO [se\analysts]
    AS [dbo];


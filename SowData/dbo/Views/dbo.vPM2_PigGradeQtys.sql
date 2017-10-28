--------------------------------------------------------------------------------------------------------------------
-- Summary of graded pig qtys by grade type for each sow farm
-- This information is loaded into Essbase
-- NOTE: 
--------------------------------------------------------------------------------------------------------------------
CREATE VIEW vPM2_PigGradeQtys
	(FarmID, WeekOfDate, Acct, Qty)
	AS
	SELECT v.FarmID, v.WeekOfDate,
	Acct=RTrim(v.GradeDescr) + 'Qty',
	Qty = Sum(IsNull(v.Qty,0))
	FROM vTransportGradeDetail v  	
	GROUP BY FarmID, WeekOfDate, GradeDescr 

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_PigGradeQtys] TO [se\analysts]
    AS [dbo];


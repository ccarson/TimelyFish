
CREATE VIEW [dbo].[vPM2_FirstWeanDetail]
as
Select FarmID, SowID, SowParity	--, min(SortCode) as SortCode
FROM SowWeanEventTemp we
WHERE (we.EventType = 'WEAN' OR (we.EventType = 'PART WEAN' and we.Qty < 3))
	AND we.Qty > 0 
Group by FarmID, SowID, SowParity


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_FirstWeanDetail] TO [se\analysts]
    AS [dbo];


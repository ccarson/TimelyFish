CREATE VIEW vFirstGroupEvent
as 
Select FarmID, SowID, Min(SortCode) as FirstGroup 
from SowGroupEventTemp
Group By FarmID, SowID 

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vFirstGroupEvent] TO [se\analysts]
    AS [dbo];

